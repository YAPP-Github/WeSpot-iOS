//
//  VoteResultViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
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




final class VoteResultViewController: BaseViewController<VoteResultViewReactor> {
    
    private lazy var voteResultCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] section, _ in
        return self?.createVoteResultSection()
    }
    private lazy var voteResultCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: voteResultCollectionViewLayout)
    private let voteResultsCollectionViewDataSources: RxCollectionViewSectionedReloadDataSource<VoteResultSection> = .init { dataSources, collectionView, indexPath, sectionItem in
        guard let voteResultsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VoteResultCollectionViewCell", for: indexPath) as? VoteResultCollectionViewCell else { return UICollectionViewCell() }
        return voteResultsCell
    }
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let backgrounImageView: UIImageView = UIImageView()
    private let resultPageControl: UIPageControl = UIPageControl()
    
    override func setupUI() {
        super.setupUI()
        view.addSubviews(voteResultCollectionView, confirmButton, backgrounImageView, resultPageControl)
    }
    
    override func setupAutoLayout() {
        super.setupAutoLayout()
        
        
        voteResultCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(391)
        }
        
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        backgrounImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        resultPageControl.snp.makeConstraints {
            $0.top.equalTo(voteResultCollectionView.snp.bottom).offset(16)
            $0.height.equalTo(31)
            $0.width.equalTo(107)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        
        voteResultCollectionView.do {
            $0.register(VoteResultCollectionViewCell.self, forCellWithReuseIdentifier: "VoteResultCollectionViewCell")
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
        backgrounImageView.do {
            $0.image = DesignSystemAsset.Images.voteBackground.image
            $0.contentMode = .scaleAspectFill
        }
        
        confirmButton.do {
            $0.setupButton(text: "내가 받은 투표 보기")
        }
        
        resultPageControl.do {
            $0.currentPage = 0
            $0.numberOfPages = 4
            $0.currentPageIndicatorTintColor = .lightGray
            $0.pageIndicatorTintColor = .gray
        }
    }
    
    override func bind(reactor: VoteResultViewReactor) {
        super.bind(reactor: reactor)
        Observable.just(())
            .map { Reactor.Action.fetchResultItems }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    
        
        reactor.state.map { $0.resultSection }
            .asDriver(onErrorJustReturn: [])
            .drive(voteResultCollectionView.rx.items(dataSource: voteResultsCollectionViewDataSources))
            .disposed(by: disposeBag)
        
    }
    
    private func createVoteResultSection() -> NSCollectionLayoutSection {
        
        let voteResultItemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(391)
        )
        
        let voteResultItem: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: voteResultItemSize)
        
        voteResultItem.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        let voteResultGroupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(391)
        )
        
        let voteResultGroup: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: voteResultGroupSize,
            subitems: [voteResultItem]
        )
        
        let voteResultSection: NSCollectionLayoutSection = NSCollectionLayoutSection(group: voteResultGroup)
        voteResultSection.orthogonalScrollingBehavior = .groupPaging
        voteResultSection.contentInsets = .init(top: 0, leading: 40, bottom: 0, trailing: 40)

        return voteResultSection
    }
}
