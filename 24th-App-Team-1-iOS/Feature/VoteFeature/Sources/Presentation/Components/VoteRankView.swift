//
//  VoteRankView.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import DesignSystem
import UIKit

import SnapKit

final class VoteRankView: UIView {
    
    //MARK: - Properties
    let rankLabel: WSLabel = WSLabel(wsFont: .Header01, text: "10표")
    let rankImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAutoLayout()
        setupAttributeds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    private func setupUI() {
        addSubviews(rankLabel, rankImageView)
    }
    
    private func setupAutoLayout() {
        
        rankImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(12)
            $0.size.equalTo(30)
            $0.centerY.equalToSuperview()
        }
        
        rankLabel.snp.makeConstraints {
            $0.left.equalTo(rankImageView.snp.right).offset(8)
            $0.height.equalTo(30)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupAttributeds() {
        rankImageView.do {
            $0.contentMode = .scaleAspectFill
        }
        
        rankLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
    }
}
