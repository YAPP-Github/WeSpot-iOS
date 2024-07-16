//
//  ConfirmInfoBottomSheetView.swift
//  LoginFeature
//
//  Created by eunseou on 7/15/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit

public final class ConfirmInfoBottomSheetView: UIView {
    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Body01, text: "해당 정보로 가입하시겠습니까?")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "가입 이후 개인 정보 변경은 1:1 문의로 요청해주세요")
    private let profileImageView = UIImageView()
    private let infoLabel = WSLabel(wsFont: .Header01)
    private let subInfoLabel = WSLabel(wsFont: .Body02)
    public let editButton = WSButton(wsButtonType: .secondaryButton).then {
        $0.setupButton(text: "수정할래요")
    }
    public let confirmButton = WSButton(wsButtonType: .default(10)).then {
        $0.setupButton(text: "네 좋아요")
    }
    
    //MARK: - Initializer
    public init() {
        super.init(frame: .zero)
        
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: - Functions
    public func setupUI() {
        
        addSubviews(titleLabel, subTitleLabel, profileImageView, infoLabel, subInfoLabel, editButton, confirmButton)
    }
    
    public func setupAutoLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(35.5)
            $0.leading.equalToSuperview().offset(36)
            $0.size.equalTo(56)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(35.5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        subInfoLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        editButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(39.5)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(52)
            $0.width.greaterThanOrEqualTo(162)
        }
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(39.5)
            $0.leading.equalTo(editButton.snp.trailing).offset(11)
            $0.height.equalTo(52)
            $0.width.greaterThanOrEqualTo(162)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    public func setupAttributes() {
        
        backgroundColor = DesignSystemAsset.Colors.gray600.color
        
        profileImageView.image = DesignSystemAsset.Images.profile.image
        
        titleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        subTitleLabel.textColor = DesignSystemAsset.Colors.gray300.color
        
        infoLabel.textColor = DesignSystemAsset.Colors.gray100.color
        infoLabel.text = "김은수 (남학생)"
    
        subInfoLabel.textColor = DesignSystemAsset.Colors.gray100.color
        subInfoLabel.text = "역삼중학교 1학년 6반"
        
        editButton.do {
            $0.setupButton(text: "수정할래요")
        }
        
        confirmButton.do {
            $0.setupButton(text: "네 좋아요")
        }
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}
