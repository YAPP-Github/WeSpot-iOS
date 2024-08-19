//
//  MainTableViewCell.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/12/24.
//

import DesignSystem
import UIKit


final class MainTableViewCell: UITableViewCell {
    
    private let contentLabel: WSLabel = WSLabel(wsFont: .Body04)
    private let contentAccessoryView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(contentLabel, contentAccessoryView)
    }
    
    private func setupAutoLayout() {
        self.do {
            $0.backgroundColor = .clear
        }
        
        contentLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        contentAccessoryView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        contentAccessoryView.do {
            $0.image = DesignSystemAsset.Images.icProfileArrowFiled.image
        }
        
        contentLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
    }
    
    public func bind(_ text: String) {
        contentLabel.text = text
    }
    
}
