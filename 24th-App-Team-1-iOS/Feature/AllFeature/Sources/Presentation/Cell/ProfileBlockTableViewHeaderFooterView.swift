//
//  ProfileBlockTableViewHeaderFooterView.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import DesignSystem
import UIKit


final class ProfileBlockTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    private let titleLabel: WSLabel = WSLabel(wsFont: .Header01)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
    
    private func setupAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupAttributeds() {
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "차단 목록"
            $0.textAlignment = .left
        }
    }
    
}
