//
//  WSAlertView.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/9/24.
//

import UIKit

import SnapKit
import Then


public final class WSAlertView: UIViewController {
    
    //MARK: Properties
    private let containerView: UIView = UIView()
    var titleLabel: WSLabel = WSLabel(wsFont: .Header01)
    var messageLabel: WSLabel = WSLabel(wsFont: .Body06)
    var confirmButton: WSButton = WSButton(wsButtonType: .default(10))
    var cancelButton: WSButton = WSButton(wsButtonType: .secondaryButton)
    var alertAction: WSAlertActionProperty?
    
    var alertType: AlertType = .titleWithMeesage
    private var titleText: String?
    private var messageText: String?
    private var confirmText: String?
    private var cancelText: String?
    
    //MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    //MARK: Configure
    private func setupUI() {
        view.addSubview(containerView)
        switch alertType {
        case .message:
            containerView.addSubviews(titleLabel, confirmButton, cancelButton)
        case .titleWithMeesage:
            containerView.addSubviews(titleLabel, messageLabel, confirmButton, cancelButton)
        }
    }
    
    
    private func setupAutoLayout() {
        
        switch alertType {
        case .message:
            containerView.snp.makeConstraints {
                $0.height.equalTo(158)
                $0.width.equalTo(310)
                $0.center.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(32)
                $0.horizontalEdges.equalToSuperview().inset(20)
                $0.height.equalTo(30)
            }
            
            confirmButton.snp.makeConstraints {
                $0.right.equalToSuperview().offset(-20)
                $0.height.equalTo(52)
                $0.bottom.equalToSuperview().offset(-20)
                $0.width.equalTo(131)
            }
            
            cancelButton.snp.makeConstraints {
                $0.left.equalToSuperview().offset(20)
                $0.height.equalTo(52)
                $0.bottom.equalToSuperview().offset(-20)
                $0.width.equalTo(131)
            }
            
            
        case .titleWithMeesage:
            //HACK: 추후 리펙토링
            containerView.snp.makeConstraints {
                $0.height.equalTo(208)
                $0.width.equalTo(310)
                $0.center.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(32)
                $0.height.equalTo(32)
                $0.centerX.equalToSuperview()
            }
            
            messageLabel.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().offset(20)
                $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            }
            
            confirmButton.snp.makeConstraints {
                $0.right.equalToSuperview().offset(-20)
                $0.height.equalTo(52)
                $0.bottom.equalToSuperview().offset(-20)
                $0.width.equalTo(131)
            }
            
            cancelButton.snp.makeConstraints {
                $0.left.equalToSuperview().offset(20)
                $0.height.equalTo(52)
                $0.bottom.equalToSuperview().offset(-20)
                $0.width.equalTo(131)
            }
        }
        
    }
    
    private func setupAttributes() {
        view.do {
            $0.backgroundColor = .black.withAlphaComponent(0.6)
        }
        
        containerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray600.color
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = alertType == .message ? .left : .center
        }
        
        messageLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        confirmButton.do {
            $0.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        }
        
        cancelButton.do {
            $0.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        }
    }
    
    
    @objc
    private func didTapConfirmButton() {
        self.dismiss(animated: true) { [weak self] in
            self?.alertAction?.confirmAction?()
        }
    }
    
    @objc
    private func didTapCancelButton() {
        alertAction?.cancelAction?()
        dismiss(animated: true)
    }
}
