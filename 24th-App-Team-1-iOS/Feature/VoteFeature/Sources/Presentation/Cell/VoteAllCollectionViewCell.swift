//
//  VoteAllCollectionViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/30/24.
//

import UIKit

import SnapKit
import Then
import RxDataSources
import ReactorKit



final class VoteAllCollectionViewCell: UICollectionViewCell {
    
    var disposeBag: DisposeBag = DisposeBag()
    private lazy var completeAllCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] section, _ in
        let sectionItem = self?.completeAllCollectionViewDataSources[section]
        
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
    
    private lazy var completeAllCollectionViewDataSources: RxCollectionViewSectionedReloadDataSource<VoteAllCompleteSection> = .init { dataSources, collectionView, indexPath, sectionItem in
        switch sectionItem {
        case .voteHighRankerItem:
            guard let highRankerCell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCompleteId.voteHighCell, for: indexPath) as? VoteHighCollectionViewCell else { return UICollectionViewCell() }
            
            return highRankerCell
        case .voteLowRankerItem:
            guard let rowRankerCell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCompleteId.voteLowCell, for: indexPath) as? VoteLowCollectionViewCell else { return UICollectionViewCell() }
            return rowRankerCell
        }
    }
    
    private lazy var completeAllCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: completeAllCollectionViewLayout)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(completeAllCollectionView)
    }
    
    private func setupAutoLayout() {
        completeAllCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        completeAllCollectionView.do {
            $0.register(VoteHighCollectionViewCell.self, forCellWithReuseIdentifier: VoteCompleteId.voteHighCell)
            $0.register(VoteLowCollectionViewCell.self, forCellWithReuseIdentifier: VoteCompleteId.voteLowCell)
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
    }
}

extension VoteAllCollectionViewCell: ReactorKit.View {
    
    func bind(reactor: VoteAllCellReactor) {
        
        reactor.pulse(\.$completeSection)
            .asDriver(onErrorJustReturn: [])
            .drive(completeAllCollectionView.rx.items(dataSource: completeAllCollectionViewDataSources))
            .disposed(by: disposeBag)
    }
}


extension VoteAllCollectionViewCell {
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
            widthDimension: .absolute(contentView.frame.width),
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
            widthDimension: .absolute(contentView.frame.width - 60),
            heightDimension: .absolute(78)
        )
        
        let rankerVerticalItem: NSCollectionLayoutItem = .init(layoutSize: rankerVerticalItemSize)
        
        
        let rankerVerticalGroupSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(contentView.frame.width - 60),
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
