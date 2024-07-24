//
//  ReservedMessageTableViewCell.swift
//  MessageFeature
//
//  Created by eunseou on 7/20/24.
//

import UIKit
import Util
import DesignSystem

import SnapKit
import Then

public final class ReservedMessageTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    public static let identifier = "ReservedMessageTableViewCell"
    
    //MARK: - Properties
    private let profileImageView = UIImageView()
    private let toLabel = WSLabel(wsFont: .Body06, text: "To.")
    private let recipientLabel = WSLabel(wsFont: .Body06)
    private let editButton = UIButton()
    private let borderLine = UIView()
    
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
        
        contentView.addSubviews(profileImageView, toLabel, recipientLabel, editButton, borderLine)
    }
    
    private func setupAutoLayout() {
        
        profileImageView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView).inset(24)
            $0.leading.equalTo(contentView).offset(19)
            $0.size.equalTo(40)
        }
        toLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(contentView).offset(24)
        }
        recipientLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(toLabel.snp.bottom)
            $0.trailing.equalTo(toLabel.snp.trailing)
        }
        editButton.snp.makeConstraints {
            $0.leading.equalTo(toLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(contentView).inset(18)
            $0.height.equalTo(28)
            $0.width.equalTo(62)
            $0.centerY.equalTo(profileImageView)
        }
        borderLine.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(20)
            $0.bottom.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    private func setupAttributes() {
        
        backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        toLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        recipientLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        editButton.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray500.color
            $0.titleLabel?.font = WSFont.Body09.font()
            $0.setTitle("수정하기", for: .normal)
            $0.setTitleColor(DesignSystemAsset.Colors.gray100.color, for: .normal)
            $0.layer.cornerRadius = 14
        }
        
        borderLine.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
        }
    }
    
    public func configureCell(image: UIImage, text: String) {
        
        profileImageView.image = image
        recipientLabel.text = text
    }
}
