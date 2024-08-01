//
//  VoteEmptyCollectionViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/31/24.
//

import DesignSystem
import UIKit

import ReactorKit


final class VoteEmptyCollectionViewCell: UICollectionViewCell {
    
    private let emptyImageView: UIImageView = UIImageView()
    private let emptyVoteTitleLabel: WSLabel = WSLabel(wsFont: .Header01)
    private let emptyTitleLabel: WSLabel = WSLabel(wsFont: .Body01)
    private let emptySubTitleLabel: WSLabel = WSLabel(wsFont: .Body05)
    var disposeBag: DisposeBag = DisposeBag()
    
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
        contentView.addSubviews(emptyImageView, emptyTitleLabel, emptyVoteTitleLabel, emptySubTitleLabel)
    }
    
    private func setupAutoLayout() {
        emptyImageView.snp.makeConstraints {
            $0.size.equalTo(80)
            $0.center.equalToSuperview()
        }
        
        emptyVoteTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        emptyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(25)
            $0.height.equalTo(24)
            $0.centerX.equalToSuperview()
        }
        
        emptySubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyTitleLabel.snp.bottom).offset(5)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        
        emptyVoteTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        emptyImageView.do {
            $0.image = DesignSystemAsset.Images.imgEmptyVoteFiled.image
            $0.contentMode = .scaleAspectFill
        }
        
        emptyTitleLabel.do {
            $0.text = "아직 받은 투표가 없어요"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        emptySubTitleLabel.do {
            $0.text = "친구들이 초대하면 투표를 확률이 올라가요"
            $0.textColor = DesignSystemAsset.Colors.gray500.color
        }
        
    }
}

extension VoteEmptyCollectionViewCell: ReactorKit.View {

    func bind(reactor: VoteEmptyCellReactor) {
        reactor.state
            .map { $0.content }
            .distinctUntilChanged()
            .bind(to: emptyVoteTitleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
