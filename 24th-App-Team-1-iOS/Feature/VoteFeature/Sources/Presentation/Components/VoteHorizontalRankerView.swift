//
//  VoteHorizontalRankerView.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/20/24.
//

import DesignSystem
import UIKit


final class VoteHorizontalRankerView: UIView {
    
    private let containerView: UIView = UIView()
    private let profileContainerView: UIView = UIView()
    let crownImageView: UIImageView = UIImageView()
    let profileImageView: UIImageView = UIImageView()
    let rankLabel: WSLabel = WSLabel(wsFont: .Body01)
    private let profileNameLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let profileDescriptionLabel: WSLabel = WSLabel(wsFont: .Badge)
    
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
        profileContainerView.addSubview(profileImageView)
        containerView.addSubviews(rankLabel, profileContainerView, profileNameLabel, profileDescriptionLabel, crownImageView)
        addSubviews(containerView)
    }
    
    private func setupAttributes() {
        
        containerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.layer.cornerRadius = 12
        }
        
        rankLabel.do {
            $0.textAlignment = .center
        }
        
        profileContainerView.do {
            $0.layer.cornerRadius = 50 / 2
            $0.clipsToBounds = true
        }
        
        profileImageView.do {
            $0.image = DesignSystemAsset.Images.boy.image
        }
        
        profileNameLabel.do {
            $0.text = "은미쿠"
            $0.textAlignment = .center
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        profileDescriptionLabel.do {
            $0.text = "안녕하세요저는아아박주현이에요..."
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.textAlignment = .center
        }
        
        
        
    }
    
    private func setupAutoLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        crownImageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(-28)
            $0.centerX.equalToSuperview()
        }
        
        rankLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.height.equalTo(27)
            $0.centerX.equalToSuperview()
        }
        
        profileContainerView.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.top.equalTo(rankLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(4)
            $0.height.equalTo(27)
            $0.centerX.equalToSuperview()
        }
        
        profileDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(profileNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(7)
        }
    }
}
