//
//  VoteInventoryHeaderFooterView.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/9/24.
//

import DesignSystem
import UIKit

final class VoteInventoryHeaderFooterView: UITableViewHeaderFooterView {
    private let titleLabel: WSLabel = WSLabel(wsFont: .Body03)
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        tintColor = DesignSystemAsset.Colors.gray900.color
        setupUI()
        setupAutoLayout()
        setupAttributeds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupAttributeds() {
        self.do {
            $0.backgroundColor = .clear
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "오늘"
        }
    }
    
    private func setupAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(24)
        }
    }
}
