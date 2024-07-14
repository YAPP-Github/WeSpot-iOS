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
        
        addSubviews(schoolCellView)
        schoolCellView.addSubviews(schoolImageView, titleLabel, subTitleLabel, checkButton)
    }
    
    private func setupAutoLayout() {
        
        schoolCellView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(88)
            $0.bottom.equalToSuperview().inset(16)
        }
        schoolImageView.snp.makeConstraints {
            $0.verticalEdges.equalTo(schoolCellView).inset(16)
            $0.leading.equalTo(schoolCellView).offset(24)
            $0.size.height.equalTo(56)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(schoolCellView).offset(16)
            $0.leading.equalTo(schoolImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(schoolCellView).inset(44)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(schoolImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(schoolCellView).inset(44)
            $0.bottom.equalTo(schoolImageView.snp.bottom).inset(4)
        }
        checkButton.snp.makeConstraints {
            $0.top.trailing.equalTo(schoolCellView).inset(14)
            $0.size.equalTo(20)
        }
    }
    
    private func setupAttributes() {
        
        backgroundColor = .clear
        
        schoolCellView.backgroundColor = DesignSystemAsset.Colors.gray700.color
        
        schoolImageView.backgroundColor = DesignSystemAsset.Colors.white.color
        
        titleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        subTitleLabel.textColor = DesignSystemAsset.Colors.gray300.color
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        schoolCellView.layer.cornerRadius = 12
        schoolCellView.layer.masksToBounds = true

        schoolImageView.layer.cornerRadius = schoolImageView.bounds.height / 2
        schoolImageView.layer.masksToBounds = true
    }
    
    public func setupCell(schoolName: String, address: String) {
        
        titleLabel.text = schoolName
        subTitleLabel.text = address
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            schoolCellView.layer.borderColor = DesignSystemAsset.Colors.primary400.color.cgColor
            schoolCellView.layer.borderWidth = 1
            
            checkButton.setImage(DesignSystemAsset.Images.checkSelected.image, for: .normal)
        } else {
            schoolCellView.layer.borderWidth = 0
            
            checkButton.setImage(DesignSystemAsset.Images.check.image, for: .normal)
        }
    }
    
}
