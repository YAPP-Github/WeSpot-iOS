//
//  VoteCompleteViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/24/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit

typealias VoteCompleteStr = VoteStrings
typealias VoteCompleteId = VoteStrings.Identifier
public final class VoteCompleteViewController: BaseViewController<VoteCompleteViewReactor> {

    //MARK: - Properties
    private let onboardingView: VoteCompleteOnBoardingView = VoteCompleteOnBoardingView()
    private let lendingView: VoteCompleteLandingView = VoteCompleteLandingView()
    private let loadingIndicator: WSLottieIndicatorView = WSLottieIndicatorView()
    private let noticeButton: WSButton = WSButton(wsButtonType: .default(12))
    private let shareButton: UIButton = UIButton()
    private let completePageControl: UIPageControl = UIPageControl()
    
    private lazy var completeCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] section, _ in
        let sectionItem = self?.completeCollectionViewDataSources[section]
        
        switch sectionItem {
        case .voteAllRankerInfo:
            return self?.createRankerAllLayoutSection()
        case .voteAllEmptyRankerInfo:
            return self?.createEmptyRankerLayoutSection()
        case .none:
            break
        }
        return nil
    }
    
    private lazy var completeCollectionViewDataSources: RxCollectionViewSectionedReloadDataSource<VoteCompleteSection> = .init { dataSources, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .voteAllRankerItem(cellReactor):
            
            guard let allRankerCell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCompleteId.voteAllCell, for: indexPath) as? VoteAllCollectionViewCell else { return UICollectionViewCell() }
            allRankerCell.reactor = cellReactor
            return allRankerCell
        case let .voteAllEmptyItem(cellReactor):
            guard let allEmtpyCell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCompleteId.voteEmptyCell, for: indexPath) as? VoteEmptyCollectionViewCell else { return UICollectionViewCell() }
            allEmtpyCell.reactor = cellReactor
            return allEmtpyCell
        }
    }
    
    private lazy var completeCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: completeCollectionViewLayout)
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(shareButton, completePageControl, noticeButton, completeCollectionView, lendingView, onboardingView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        onboardingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lendingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        noticeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
            $0.left.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        shareButton.snp.makeConstraints {
            $0.left.equalTo(noticeButton.snp.right).offset(15)
            $0.size.equalTo(52)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
        }
        
        completeCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        completePageControl.snp.makeConstraints {
            $0.top.equalTo(completeCollectionView.snp.bottom).offset(46)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        self.do {
            $0.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .rightItem("처음으로"))
            $0.setNavigationBarAutoLayout(property: .rightIcon(56, 24))
        }
    
        shareButton.do {
            $0.configuration = .filled()
            $0.layer.cornerRadius = 11
            $0.clipsToBounds = true
            $0.configuration?.baseBackgroundColor = DesignSystemAsset.Colors.gray500.color
            $0.configuration?.image = DesignSystemAsset.Images.icCompleteShareOutline.image
        }
        
        noticeButton.do {
            $0.setupButton(text: VoteCompleteStr.voteNoticeText)
            $0.setupFont(font: .Body03)
        }
        
        completePageControl.do {
            $0.currentPage = 0
            $0.numberOfPages = 3
        }
        
        completeCollectionView.do {
            $0.register(VoteAllCollectionViewCell.self, forCellWithReuseIdentifier: VoteCompleteId.voteAllCell)
            $0.register(VoteEmptyCollectionViewCell.self, forCellWithReuseIdentifier: VoteCompleteId.voteEmptyCell)
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = false
        }
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        navigationBar
            .rightBarButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.navigationController?.popToRootViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        noticeButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.shareToKakaoTalk()
            }
            .disposed(by: disposeBag)
        
        shareButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.shareToInstagramStory(to: owner.completeCollectionView)
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .bind(to: loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$completeSection)
            .asDriver(onErrorJustReturn: [])
            .drive(completeCollectionView.rx.items(dataSource: completeCollectionViewDataSources))
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$voteAllEntity)
            .map { $0.count }
            .bind(to: completePageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.currentPage }
            .distinctUntilChanged()
            .bind(to: completePageControl.rx.currentPage)
            .disposed(by: disposeBag)
        
        lendingView
            .rx.swipeGestureRecognizer(direction: .left)
            .bind(with: self) { owner, _ in
                owner.fadeInOutLendigView()
            }
            .disposed(by: disposeBag)
        
        
        reactor.pulse(\.$isOnboarding)
            .filter { $0 == true }
            .bind(with: self) { owner, _ in
                owner.fadeInOutOnAnimationView()
            }
            .disposed(by: disposeBag)
    }
    
    private func createEmptyRankerLayoutSection() -> NSCollectionLayoutSection {
 
        let emptyRankerGroupSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(view.frame.width),
            heightDimension: .absolute(430)
        )
        
        let emptyRankerGroup: NSCollectionLayoutGroup = NSCollectionLayoutGroup(layoutSize: emptyRankerGroupSize)
        
        
        let emptyRankerSection: NSCollectionLayoutSection = NSCollectionLayoutSection(group: emptyRankerGroup)
        emptyRankerSection.orthogonalScrollingBehavior = .none
        
        
        return emptyRankerSection
    }
    
    private func createRankerAllLayoutSection() -> NSCollectionLayoutSection {
        let rankerAllItemSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(view.frame.width),
            heightDimension: .absolute(500)
        )
        
        let rankerAllItem: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: rankerAllItemSize)
        
        let rankerGroupSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(view.frame.width),
            heightDimension: .absolute(500)
        )
        
        let rankerAllGroup: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: rankerGroupSize,
            subitems: [rankerAllItem]
        )
        
        let rankerGroupSection: NSCollectionLayoutSection = NSCollectionLayoutSection(group: rankerAllGroup)
        
        rankerGroupSection.visibleItemsInvalidationHandler = { [weak self] visibleItems, offset, env in
            let position = offset.x / env.container.contentSize.width
            let roundPosition = Int(round(position))
            self?.reactor?.action.onNext(.didShowVisibleCell(roundPosition))
        }
        
        rankerGroupSection.orthogonalScrollingBehavior = .groupPaging
        return rankerGroupSection
    }
}


extension VoteCompleteViewController {
    private func fadeInOutLendigView() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut) { [weak self] in
            self?.lendingView.alpha = 0.0
        } completion: { [weak self] _ in
            self?.lendingView.removeFromSuperview()
        }
    }
    
    private func fadeInOutOnAnimationView() {
        UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseInOut) { [weak self] in
            self?.onboardingView.alpha = 0.0
        } completion: { [weak self] _ in
            self?.onboardingView.removeFromSuperview()
        }
    }
}
