//
//  VoteLowCollectionViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/29/24.
//

import DesignSystem
import UIKit


final class VoteLowCollectionViewCell: UICollectionViewCell {
    
    private let rankLabel: WSLabel = WSLabel(wsFont: .Body01)
    private let userContainerView: UIView = UIView()
    private let userProfileImageView: UIImageView = UIImageView()
    private let userNameLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let introduceLabel: WSLabel = WSLabel(wsFont: .Body09)
    private let voteCountLabel: WSLabel = WSLabel(wsFont: .Body02)
    
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
        userContainerView.addSubview(userProfileImageView)
        contentView.addSubviews(rankLabel, userContainerView, userNameLabel, introduceLabel, voteCountLabel)
    }
    
    private func setupAutoLayout() {
        rankLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.height.equalTo(27)
            $0.width.equalTo(14)
            $0.centerY.equalToSuperview()
        }
        
        userContainerView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(rankLabel.snp.right).offset(18)
        }
        
        userProfileImageView.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.center.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userContainerView)
            $0.left.equalTo(userContainerView.snp.right).offset(16)
            $0.height.equalTo(27)
        }
        
        introduceLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.left.equalTo(userNameLabel)
            $0.right.equalTo(voteCountLabel.snp.left)
            $0.bottom.equalTo(userContainerView)
        }
        
        voteCountLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(27)
            $0.width.equalTo(38)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        userContainerView.do {
            $0.layer.cornerRadius = 48 / 2
            $0.clipsToBounds = true
            //TODO: 테스트 코드
            $0.backgroundColor = DesignSystemAsset.Colors.primary300.color
        }
        
        userProfileImageView.do {
            //TODO: 테스트 코드
            $0.image = DesignSystemAsset.Images.icCommonProfile427323024.image
            $0.contentMode = .scaleAspectFill
        }
        
        userNameLabel.do {
            $0.text = "김쥬시"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        introduceLabel.do {
            $0.text = "안녕하세요저는아아박주현이에요요..."
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.lineBreakMode = .byTruncatingTail
        }
        
        voteCountLabel.do {
            $0.text = "10표"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        rankLabel.do {
            $0.text = "4"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
    }
    
}
