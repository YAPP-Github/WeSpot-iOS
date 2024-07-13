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
    
    //MARK: Properties
    let rankLabel: WSLabel = WSLabel(wsFont: .Header01)
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
    
    //MARK: Configure
    private func setupUI() {
        addSubviews(rankLabel, rankImageView)
    }
    
    private func setupAutoLayout() {
        rankLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(3)
            $0.right.equalToSuperview().inset(10)
            
        }
        
        rankImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(3)
            $0.left.equalToSuperview().inset(10)
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
