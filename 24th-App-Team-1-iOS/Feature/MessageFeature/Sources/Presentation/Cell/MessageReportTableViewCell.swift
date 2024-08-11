//
//  messageReportTableViewCell.swift
//  MessageFeature
//
//  Created by eunseou on 7/24/24.
//

import UIKit
import Util
import DesignSystem

import SnapKit
import Then

public final class MessageReportTableViewCell: UITableViewCell {

    //MARK: - Identifier
    public static let identifier = "MessageReportTableViewCell"
    
    //MARK: - Properties
    private let checkButton = UIButton()
    private let titleLabel = WSLabel(wsFont: .Body04)
    
    //MARK: - Initialize
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupUI() {
        
        contentView.addSubviews(checkButton, titleLabel)
    }
    
    private func setupAutoLayout() {
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.bottom.equalToSuperview().offset(-6)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        checkButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView).inset(17)
            $0.leading.equalTo(contentView).offset(15)
            $0.size.equalTo(26)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(7)
            $0.centerY.equalTo(checkButton)
            $0.trailing.lessThanOrEqualTo(contentView).offset(-15)
        }
    }
    
    private func setupAttributes() {
        
        backgroundColor = .clear
        
        contentView.do {
            $0.layer.masksToBounds = true
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.layer.cornerRadius = 12
        }
        
        checkButton.do {
            $0.setImage(DesignSystemAsset.Images.check.image, for: .normal)
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
    }
    
    public func configureCell(text: String, isSelected: Bool) {
        
        titleLabel.text = text
        checkButton.setImage(isSelected ? DesignSystemAsset.Images.check.image:  DesignSystemAsset.Images.checkSelected.image, for: .normal)
    }

}
