//
//  VoteVerticalRankerView.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/20/24.
//

import DesignSystem
import UIKit


final class VoteVerticalRankerView: UIView {
    public let rankerLabel: WSLabel = WSLabel(wsFont: .Body01)
    public let profileImageView: UIImageView = UIImageView()
    private let userNameLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let userIntroduceLabel: WSLabel = WSLabel(wsFont: .Body09)
    public let voteCountLabel: WSLabel = WSLabel(wsFont: .Body02)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(rankerLabel, profileImageView, userNameLabel, userIntroduceLabel, voteCountLabel)
    }
    
    private func setupAttributes() {
        rankerLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .center
        }
        
        profileImageView.do {
            $0.layer.cornerRadius = 48 / 2
            $0.image = DesignSystemAsset.Images.boy.image
        }
        
        userNameLabel.do {
            $0.text = "김쥬시"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .left
        }
        
        userIntroduceLabel.do {
            $0.text = "안녕하세요저는아아박주현이에요요..."
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.textAlignment = .left
        }
        
        voteCountLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .right
        }
        
    }
    
    private func setupAutoLayout() {
        rankerLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.height.equalTo(27)
            $0.centerY.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.left.equalTo(rankerLabel.snp.right).offset(18)
            $0.centerY.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(profileImageView.snp.right).offset(18)
            $0.height.equalTo(27)
        }
        
        userIntroduceLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom)
            $0.left.equalTo(profileImageView.snp.right).offset(18)
            $0.height.equalTo(18)
        }
        
        voteCountLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(27)
            $0.width.equalTo(38)
            $0.centerY.equalToSuperview()
        }
        
        
    }
    
}
