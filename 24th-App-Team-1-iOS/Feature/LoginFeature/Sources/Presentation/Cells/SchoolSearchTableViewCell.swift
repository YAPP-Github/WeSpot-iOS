//
//  SchoolSearchTableViewCell.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import UIKit
import DesignSystem

import SnapKit

public final class SchoolSearchTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    public static let identifier = "SchoolSearchTableViewCell"
    
    //MARK: - Properties
    private let schoolCellView = UIView()
    private let schoolImageView = UIImageView()
    private let titleLabel = WSLabel(wsFont: .Body02, text: "학교")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "주소....")
    private let checkButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Images.check.image, for: .normal)
    }
    
    //MARK: - Initializer
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
        
        schoolCellView.addSubviews(schoolImageView, titleLabel, subTitleLabel, checkButton)
        contentView.addSubview(schoolCellView)
    }
    
    private func setupAutoLayout() {
        
        schoolCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        schoolImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(schoolCellView).offset(24)
            $0.size.equalTo(56)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(schoolImageView.snp.top)
            $0.left.equalTo(schoolImageView.snp.right).offset(16)
            $0.right.equalTo(checkButton.snp.left)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalTo(schoolImageView.snp.right).offset(16)
            $0.right.equalTo(schoolCellView).offset(-44)
        }
        checkButton.snp.makeConstraints {
            $0.top.equalTo(schoolCellView).offset(14)
            $0.right.equalTo(schoolCellView).offset(-14)
            $0.size.equalTo(20)
        }
    }
    
    private func setupAttributes() {
        
        backgroundColor = .clear
        
        contentView.do {
            $0.layer.cornerRadius = 12
            $0.layer.masksToBounds = true
        }
        
        schoolImageView.do {
            $0.layer.cornerRadius = 56 / 2
            $0.clipsToBounds = true
            $0.image = DesignSystemAsset.Images.imgSignupSchoolFiled.image
        }
        
        schoolCellView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
        }
        
        titleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        subTitleLabel.textColor = DesignSystemAsset.Colors.gray300.color
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
    }
    
    public func setupCell(schoolName: String, address: String) {
        
        titleLabel.text = schoolName
        subTitleLabel.text = address
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.layer.borderColor = DesignSystemAsset.Colors.primary400.color.cgColor
            contentView.layer.borderWidth = 1
            
            checkButton.setImage(DesignSystemAsset.Images.checkSelected.image, for: .normal)
        } else {
            contentView.layer.borderWidth = 0
            
            checkButton.setImage(DesignSystemAsset.Images.check.image, for: .normal)
        }
    }
    
}
