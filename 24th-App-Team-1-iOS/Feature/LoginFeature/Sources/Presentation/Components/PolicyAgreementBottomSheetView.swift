//
//  PolicyAgreementBottomSheetView.swift
//  LoginFeature
//
//  Created by eunseou on 7/15/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit

public final class PolicyAgreementBottomSheetView: UIView {
    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Body01, text: "서비스 사용을 위한\n약관에 동의해 주세요")
    
    public let confirmButton = WSButton(wsButtonType: .default(12)).then {
        $0.setupButton(text: "동의하고 시작하기")
    }
    private let subView = UIView()
    private let allAggreementButton = SelectPolicyAgreementView(text: "전체 동의하기", font: .Body04, isHiddenDetailButton: true)
    private let serviceAgreementButton = SelectPolicyAgreementView(text: "(필수) 서비스 이용약관")
    private let privacyAgreementButton = SelectPolicyAgreementView(text: "(필수) 개인정보 수집 및 이용 안내")
    private let marketingAgreementButton = SelectPolicyAgreementView(text: "(선택) 이벤트 및 마케팇 수신 동의")
    
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
        
        addSubviews(titleLabel, subView, allAggreementButton, serviceAgreementButton, privacyAgreementButton, marketingAgreementButton, confirmButton)
    }
    
    public func setupAutoLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        subView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.height.equalTo(60)
        }
        allAggreementButton.snp.makeConstraints {
            $0.leading.equalTo(subView).offset(15)
            $0.centerY.equalTo(subView)
        }
        serviceAgreementButton.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(36)
        }
        privacyAgreementButton.snp.makeConstraints {
            $0.top.equalTo(serviceAgreementButton.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(36)
        }
        marketingAgreementButton.snp.makeConstraints {
            $0.top.equalTo(privacyAgreementButton.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(36)
        }
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(marketingAgreementButton.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(44)
        }
    }
    
    public func setupAttributes() {
        
        backgroundColor = DesignSystemAsset.Colors.gray600.color
        
        subView.backgroundColor = DesignSystemAsset.Colors.gray700.color
        subView.layer.cornerRadius = 12
        
        titleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}
