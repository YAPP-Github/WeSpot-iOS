//
//  VoteEffectViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/3/24.
//

import DesignSystem
import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import RxDataSources

public final class VoteEffectViewController: BaseViewController<VoteEffectViewReactor> {

    //MARK: - Properties
    private let realTimeButton: UIButton = UIButton(type: .custom)
    private let lastTimeButton: UIButton = UIButton(type: .custom)
    private let noticeButton: WSButton = WSButton(wsButtonType: .default(12))
    private let shareButton: UIButton = UIButton()
    private let effectPageControl: UIPageControl = UIPageControl()
    private lazy var effectCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] section, _ in
        let sectionItem = self?.effectCollectionViewDataSources[section]
        
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
    
    private lazy var effectCollectionViewDataSources: RxCollectionViewSectionedReloadDataSource<VoteCompleteSection> = .init { dataSources, collectionView, indexPath, sectionItem in
        
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
    
    private lazy var effectCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: effectCollectionViewLayout)
    
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(realTimeButton, lastTimeButton ,shareButton, effectPageControl, noticeButton, effectCollectionView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        lastTimeButton.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(6)
            $0.width.equalTo(76)
            $0.height.equalTo(31)
            $0.left.equalToSuperview().inset(20)
        }
        
        realTimeButton.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(6)
            $0.width.equalTo(88)
            $0.height.equalTo(31)
            $0.left.equalTo(lastTimeButton.snp.right).offset(12)
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
        
        effectCollectionView.snp.makeConstraints {
            $0.top.equalTo(realTimeButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        effectPageControl.snp.makeConstraints {
            $0.top.equalTo(effectCollectionView.snp.bottom).offset(56)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        realTimeButton.do {
            $0.setTitleColor(DesignSystemAsset.Colors.gray100.color, for: .selected)
            $0.setTitleColor(DesignSystemAsset.Colors.gray400.color, for: .normal)
            $0.setTitle("실시간 투표", for: .normal)
            $0.titleLabel?.font = WSFont.Body05.font()
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
            $0.backgroundColor = DesignSystemAsset.Colors.gray500.color
        }
        
        lastTimeButton.do {
            $0.setTitleColor(DesignSystemAsset.Colors.gray100.color, for: .selected)
            $0.setTitleColor(DesignSystemAsset.Colors.gray400.color, for: .normal)
            $0.layer.borderColor = DesignSystemAsset.Colors.gray400.color.cgColor
            $0.layer.borderWidth = 1
            $0.setTitle("지난 투표", for: .normal)
            $0.titleLabel?.font = WSFont.Body05.font()
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
            $0.backgroundColor = .clear
        }
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
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
        
        effectPageControl.do {
            $0.currentPage = 0
            $0.numberOfPages = 3
        }
        
        effectCollectionView.do {
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
        Observable.just(())
            .map { Reactor.Action.fetchlatestAllVoteOption }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        lastTimeButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { Reactor.Action.fetchPreviousAllVoteOptions }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        realTimeButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { Reactor.Action.fetchlatestAllVoteOption }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.pulse(\.$completeSection)
            .asDriver(onErrorJustReturn: [])
            .drive(effectCollectionView.rx.items(dataSource: effectCollectionViewDataSources))
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$voteAllEntity)
            .map { $0.count }
            .distinctUntilChanged()
            .bind(to: effectPageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.currentPage }
            .distinctUntilChanged()
            .bind(to: effectPageControl.rx.currentPage)
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
