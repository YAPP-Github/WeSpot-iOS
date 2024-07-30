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
    private let descrptionLabel: WSLabel = WSLabel(wsFont: .Header01, text: VoteCompleteStr.voteCompleteText)
    private let noticeButton: WSButton = WSButton(wsButtonType: .default(12))
    private let shareButton: UIButton = UIButton()
    
    private lazy var completeCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self ] section, _ in
        let sectionItem = self?.completeCollectionViewDataSources[section]
        
        switch sectionItem {
        case .voteHighRankerInfo:
            return self?.createRankerHorizontalSection()
        case .voteLowRankerInfo:
            return self?.createRankerVerticalSection()
        case .none:
            break
        }
        return nil
    }
    
    private lazy var completeCollectionViewDataSources: RxCollectionViewSectionedReloadDataSource<VoteCompleteSection> = .init { dataSources, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case .voteHighRankerItem:
            guard let highRankerCell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCompleteId.voteHighCell, for: indexPath) as? VoteHighCollectionViewCell else { return UICollectionViewCell() }
            
            return highRankerCell
        case .voteLowRankerItem:
            guard let rowRankerCell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCompleteId.voteLowCell, for: indexPath) as? VoteLowCollectionViewCell else { return UICollectionViewCell() }
            return rowRankerCell
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
        view.addSubviews(shareButton, noticeButton, descrptionLabel, completeCollectionView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()

//TODO: CollectionView 테스트로로 임시 코드 주석 처리
//        onboardingView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        lendingView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
        
        descrptionLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
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
            $0.top.equalTo(descrptionLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(shareButton.snp.top)
        }
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .rightIcon("처음으로"))
            $0.setNavigationBarAutoLayout(property: .rightIcon)
        }
    
        descrptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
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
        
        completeCollectionView.do {
            $0.register(VoteHighCollectionViewCell.self, forCellWithReuseIdentifier: VoteCompleteId.voteHighCell)
            $0.register(VoteLowCollectionViewCell.self, forCellWithReuseIdentifier: VoteCompleteId.voteLowCell)
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$completeSection)
            .asDriver(onErrorJustReturn: [])
            .drive(completeCollectionView.rx.items(dataSource: completeCollectionViewDataSources))
            .disposed(by: disposeBag)
        
//TODO: CollectionView 테스트로로 임시 코드 주석 처리
//        lendingView
//            .rx.swipeGestureRecognizer(direction: .right)
//            .bind(with: self) { owner, _ in
//                owner.fadeInOutLendigView()
//            }
//            .disposed(by: disposeBag)
//        
//        reactor.state
//            .map { $0.isLoading }
//            .distinctUntilChanged()
//            .bind(with: self) { owner, _ in
//                owner.fadeInOutOnboardingView()
//            }
//            .disposed(by: disposeBag)
    }
    
    private func createRankerHorizontalSection() -> NSCollectionLayoutSection {
        let itemWidth: CGFloat = 108
        let itemHeight: CGFloat = 172
        let spacing: CGFloat = 10
        let xOffset: CGFloat = 16
        let yOffset: CGFloat = 0
        let yOffsetIncreased: CGFloat = -36
        
        let rankerHorizontalItem = (0...2).map { index -> NSCollectionLayoutGroupCustomItem in
            let xPosition = CGFloat(index) * (itemWidth + spacing) + xOffset
            let yPosition = index == 1 ? yOffsetIncreased : yOffset
             
            return NSCollectionLayoutGroupCustomItem(
                frame: CGRect(x: xPosition, y: yPosition, width: itemWidth, height: itemHeight)
            )
         }
        
        let rankerHorizontalGroupSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(view.frame.width),
            heightDimension: .absolute(200)
        )
        
        let rankerHorizontalGroup: NSCollectionLayoutGroup = NSCollectionLayoutGroup.custom(layoutSize: rankerHorizontalGroupSize) { env in
            return rankerHorizontalItem
        }
        
        let rankerHorizontalSection: NSCollectionLayoutSection = NSCollectionLayoutSection(group: rankerHorizontalGroup)
        
        
        rankerHorizontalSection.contentInsets = .init(top: 55, leading: 0, bottom: 0, trailing: 0)
        rankerHorizontalSection.orthogonalScrollingBehavior = .none
        
        
        return rankerHorizontalSection
    }
    
    private func createRankerVerticalSection() -> NSCollectionLayoutSection {
        let rankerVerticalItemSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(view.frame.width - 60),
            heightDimension: .absolute(78)
        )
        
        let rankerVerticalItem: NSCollectionLayoutItem = .init(layoutSize: rankerVerticalItemSize)
        
        
        let rankerVerticalGroupSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(view.frame.width - 60),
            heightDimension: .absolute(156)
        )
        
        let rankerVerticalGroup: NSCollectionLayoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: rankerVerticalGroupSize,
            subitems: [rankerVerticalItem]
        )
        
        rankerVerticalGroup.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 30)
        
        let rankerVerticalSection: NSCollectionLayoutSection = NSCollectionLayoutSection(group: rankerVerticalGroup)
        
        rankerVerticalSection.orthogonalScrollingBehavior = .none
        
        return rankerVerticalSection
    }
}


extension VoteCompleteViewController {
    private func fadeInOutLendigView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.lendingView.alpha = 0.0
        } completion: { [weak self] _ in
            self?.lendingView.removeFromSuperview()
        }
    }
    
    private func fadeInOutOnboardingView() {
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseInOut) { [weak self] in
            self?.onboardingView.alpha = 0.0
        } completion: { [weak self] _ in
            self?.onboardingView.removeFromSuperview()
        }
    }
}
