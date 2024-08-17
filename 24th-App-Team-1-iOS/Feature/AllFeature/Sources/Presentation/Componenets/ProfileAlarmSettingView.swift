//
//  ProfileAlarmSettingView.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/16/24.
//

import DesignSystem
import UIKit


final class ProfileAlarmSettingView: UIView {
    private let contentLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let descriptionLabel: WSLabel = WSLabel(wsFont: .Body08)
    let toggleSwitch: UISwitch = UISwitch()
    
    public var contentText: String
    public var descriptionText: String
    public var isOn: Bool {
        didSet {
            toggleSwitch.setOn(isOn, animated: true)
        }
    }
    
    public init(contentText: String, descriptionText: String, isOn: Bool) {
        self.contentText = contentText
        self.descriptionText = descriptionText
        self.isOn = isOn
        super.init(frame: .zero)
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(contentLabel, descriptionLabel, toggleSwitch)
    }
    
    private func setupAutoLayout() {
        contentLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(24)
            $0.right.equalTo(toggleSwitch.snp.left)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(6)
            $0.height.equalTo(20)
            $0.right.equalTo(toggleSwitch.snp.left)
        }
        
        toggleSwitch.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        contentLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .left
            $0.text = contentText
        }
        
        descriptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray400.color
            $0.textAlignment = .left
            $0.text = descriptionText
        }
    }
    
}
