//
//  ProfileAccountTableViewCell.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import DesignSystem
import UIKit


public final class ProfileAccountTableViewCell: UITableViewCell {
    
    private let titleLabel: WSLabel = WSLabel(wsFont: .Body04)
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupAutoLayout()
        setupAttributes()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .clear
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
    }
    
    private func setupAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    func bind(_ text: String) {
        titleLabel.text = text
    }
}
