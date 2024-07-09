//
//  WSAlertBuilder.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/9/24.
//

import UIKit


//MARK: WSAlertView에 모든 구성요소를 설정하는 모듈
public final class WSAlertBuilder {
    
    //MARK: Properties
    private let showViewController: UIViewController
    private let alertViewController: WSAlertView = WSAlertView()
    private var builderAction: WSAlertActionProperty?
    
    private var alertTitle: String?
    private var alertMessage: String?
    private var confirmText: String?
    private var cancelText: String?
    
    public init(showViewController: UIViewController) {
        self.showViewController = showViewController
    }
    
    /// WSAlert의 타이틀을 설정하기 위한 메서드
    public func setTitle(title: String) -> Self {
        self.alertTitle = title
        return self
    }
    
    /// WSAlert의 문구를 설정하기 위한 메서드
    public func setMessage(message: String) -> Self {
        self.alertMessage = message
        return self
    }
    
    /// WSButton의 확인 버튼 문구를 설정하기 위한 메서드
    public func setConfirm(text: String) -> Self {
        self.confirmText = text
        
        return self
    }
    
    /// WSButton의 취소 버튼 문구를 설정하기 위한 메서드
    public func setCancel(text: String) -> Self {
        self.cancelText = text
        return self
    }
    
    
    /// 최종 Builder프로퍼티를 WSAlert의 적용하기 위한 메서드
    @discardableResult
    public func show() -> Self {
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        
        alertViewController.titleLabel.text = alertTitle
        alertViewController.messageLabel.text = alertMessage
        alertViewController.confirmButton.setupButton(text: confirmText ?? "")
        alertViewController.cancelButton.setupButton(text: cancelText ?? "")
        
        alertViewController.alertAction = builderAction
        showViewController.present(alertViewController, animated: true)
        
        return self
    }
    
    /// WSAlert Action을 설정하기 위한 메서드
    @discardableResult
    public func action(_ type: WSAlertActionType, action: (() -> Void)? = nil)  -> Self {
        switch type {
        case .confirm:
            builderAction = WSAlertActionProperty(confirmAction: action)
        case .cancel:
            builderAction = WSAlertActionProperty(cancelAction: action)
        }
        return self
    }
}
