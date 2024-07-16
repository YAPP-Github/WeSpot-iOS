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

fileprivate typealias VoteStr = VoteStrings
fileprivate typealias VoteId = VoteStrings.Identifier
final class VoteResultViewController: BaseViewController<VoteResultViewReactor> {
    
    //MARK: - Properties
    private lazy var voteResultCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] section, _ in
        return self?.createVoteResultSection()
    }
    private lazy var voteResultCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: voteResultCollectionViewLayout)
    private lazy var voteResultsCollectionViewDataSources: RxCollectionViewSectionedReloadDataSource<VoteResultSection> = .init { dataSources, collectionView, indexPath, sectionItem in
        guard let voteResultsCell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteId.voteReulstCell , for: indexPath) as? VoteResultCollectionViewCell else { return UICollectionViewCell() }
        return voteResultsCell
    }
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let backgrounImageView: UIImageView = UIImageView()
    private let resultPageControl: UIPageControl = UIPageControl()
    
    //MARK: - Configure
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
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-98)
        }
        
        resultPageControl.snp.makeConstraints {
            $0.top.equalTo(voteResultCollectionView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        
        voteResultCollectionView.do {
            $0.register(VoteResultCollectionViewCell.self, forCellWithReuseIdentifier: VoteId.voteReulstCell)
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
        backgrounImageView.do {
            $0.image = DesignSystemAsset.Images.voteBackground.image
            $0.contentMode = .scaleAspectFill
        }
        
        confirmButton.do {
            $0.setupButton(text: VoteStrings.voteMyResultButtonText)
        }
        
        resultPageControl.do {
            $0.currentPage = 0
            $0.numberOfPages = 3
        }
    }
    
    override func bind(reactor: VoteResultViewReactor) {
        super.bind(reactor: reactor)
        Observable.just(())
            .map { Reactor.Action.fetchResultItems }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$resultSection)
            .asDriver(onErrorJustReturn: [])
            .drive(voteResultCollectionView.rx.items(dataSource: voteResultsCollectionViewDataSources))
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.currentPage }
            .distinctUntilChanged()
            .bind(to: resultPageControl.rx.currentPage)
            .disposed(by: disposeBag)
    }
    
    private func createVoteResultSection() -> NSCollectionLayoutSection {
        
        let voteResultItemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(392)
        )
        
        let voteResultItem: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: voteResultItemSize)
        
        voteResultItem.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let voteResultGroupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(392)
        )
        
        let voteResultGroup: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: voteResultGroupSize,
            subitems: [voteResultItem]
        )
        
        let voteResultSection: NSCollectionLayoutSection = NSCollectionLayoutSection(group: voteResultGroup)
        voteResultSection.orthogonalScrollingBehavior = .groupPagingCentered
        voteResultSection.contentInsets = .init(top: 0, leading: 40, bottom: 0, trailing: 40)

        voteResultSection.visibleItemsInvalidationHandler = { [unowned self] visibleItems, offset, env in
            visibleItems.forEach { item in
                
                let position = offset.x / env.container.contentSize.width
                let roundPosition = Int(round(position))
            
                let intersectedRect = item.frame.intersection(CGRect(x: offset.x, y: offset.y, width: env.container.contentSize.width, height: item.frame.height))
                let percentVisible = intersectedRect.width / item.frame.width
                
                let originalHeight: CGFloat = 392
                let reducedHeight: CGFloat = 334
                
                let height = reducedHeight + (originalHeight - reducedHeight) * percentVisible
            
                reactor?.action.onNext(.didShowVisibleCell(roundPosition))
                item.transform = CGAffineTransform(scaleX: 1.0, y: height / originalHeight)

            }
        }
        return voteResultSection
    }
}
