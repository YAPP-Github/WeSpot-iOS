//
//  VoteHighCollectionViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/29/24.
//

import DesignSystem
import UIKit


final class VoteHighCollectionViewCell: UICollectionViewCell {
    
    private let rankerImageView: UIImageView = UIImageView()
    private let highContainerView: UIView = UIView()
    private let profileContainerView: UIView = UIView()
    private let profileImageView: UIImageView = UIImageView()
    private let voteCountLabel: WSLabel = WSLabel(wsFont: .Body01)
    private let userNameLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let profileIntroduceLabel: WSLabel = WSLabel(wsFont: .Badge)
    
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
        
        profileContainerView.addSubview(profileImageView)
        highContainerView.addSubviews(profileContainerView, voteCountLabel, profileIntroduceLabel, userNameLabel, rankerImageView)
        contentView.addSubviews(highContainerView)
    }
    
    private func setupAutoLayout() {
        
        
        rankerImageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        highContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        voteCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.height.equalTo(27)
            $0.centerX.equalToSuperview()
        }
        
        profileContainerView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.top.equalTo(voteCountLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.center.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(4)
            $0.height.equalTo(27)
            $0.centerX.equalToSuperview()
        }
        
        profileIntroduceLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(7)
            $0.height.equalTo(36)
        }
        
    }
    
    private func setupAttributes() {
        
        highContainerView.do {
            $0.layer.cornerRadius = 12
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
        }
        
        rankerImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = DesignSystemAsset.Images.icCompleteCrownFiled.image
        }
        
        voteCountLabel.do {
            $0.text = "10표"
            $0.textColor = DesignSystemAsset.Colors.primary300.color
        }
        
        profileContainerView.do {
            //TODO: 테스트 코트 서버 통신시 제거
            $0.backgroundColor = DesignSystemAsset.Colors.primary100.color
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 48 / 2
        }
        
        profileImageView.do {
            //TODO: 테스트 코트 서버 통신시 제거
            $0.image = DesignSystemAsset.Images.icCommonProfile427323024.image
        }
        
        userNameLabel.do {
            $0.text = "은미쿠"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        profileIntroduceLabel.do {
            $0.text = "안녕하세요저는아아박주현이에요..."
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.lineBreakStrategy = .hangulWordPriority
            $0.lineBreakMode = .byTruncatingTail
        }
        
        
    }
}
