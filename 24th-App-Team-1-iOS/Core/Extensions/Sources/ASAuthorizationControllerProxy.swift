//
//  ASAuthorizationControllerProxy.swift
//  Extensions
//
//  Created by eunseou on 8/1/24.
//

import UIKit

import RxCocoa
import RxSwift
import AuthenticationServices

// ASAuthorizationController에 HasDelegate 프로토콜을 확장하여 델리게이트가 ASAuthorizationControllerDelegate임을 명시
extension ASAuthorizationController: HasDelegate {
    public typealias Delegate = ASAuthorizationControllerDelegate
}

// ASAuthorizationController의 델리게이트 프록시 클래스 정의
class ASAuthorizationControllerProxy: DelegateProxy<ASAuthorizationController, ASAuthorizationControllerDelegate>, DelegateProxyType, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    /// 인증 화면을 위한 UIWindow 객체
    var presentationWindow: UIWindow = UIWindow()

    /// 초기화 메서드
    public init(controller: ASAuthorizationController) {
        super.init(parentObject: controller, delegateProxy: ASAuthorizationControllerProxy.self)
    }

    // MARK: - DelegateProxyType

    /// 델리게이트 프록시 클래스 등록 메서드
    public static func registerKnownImplementations() {
        register { ASAuthorizationControllerProxy(controller: $0) }
    }

    // MARK: - Proxy Subject

    /// 인증 완료 이벤트를 발행하는 PublishSubject
    internal lazy var didComplete = PublishSubject<ASAuthorization>()

    // MARK: - ASAuthorizationControllerDelegate

    /// 인증이 성공적으로 완료되었을 때 호출되는 메서드
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        didComplete.onNext(authorization) // 인증 성공 이벤트 발행
        didComplete.onCompleted()  // 이벤트 스트림 완료
    }

    /// 인증이 오류로 인해 완료되지 않았을 때 호출되는 메서드
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        didComplete.onCompleted() // 이벤트 스트림 완료
    }

    // MARK: - ASAuthorizationControllerPresentationContextProviding

    /// 인증 프레젠테이션을 위한 창를 제공하는 메서드
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationWindow
    }

    // MARK: - Completed

    /// 소멸자
    deinit {
        self.didComplete.onCompleted() // 객체가 소멸될 때 이벤트 스트림 완료
    }
}
