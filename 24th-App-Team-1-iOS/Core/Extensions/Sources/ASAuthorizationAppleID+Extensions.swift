//
//  ASAuthorizationAppleID+Extensions.swift
//  Extensions
//
//  Created by eunseou on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import AuthenticationServices

extension Reactive where Base: ASAuthorizationAppleIDProvider {
    public func login(scope: [ASAuthorization.Scope]? = nil, on window: UIWindow) -> Observable<ASAuthorization> {
        let request = base.createRequest()
        request.requestedScopes = scope

        let controller = ASAuthorizationController(authorizationRequests: [request])

        let proxy = ASAuthorizationControllerProxy.proxy(for: controller)
        proxy.presentationWindow = window

        controller.presentationContextProvider = proxy
        controller.performRequests()

        return proxy.didComplete
    }
}

extension Reactive where Base: ASAuthorizationAppleIDButton {
    public func loginOnTap(scope: [ASAuthorization.Scope]? = nil) -> Observable<ASAuthorization> {
        let window = base.window!
        return controlEvent(.touchUpInside)
            .flatMap {
                ASAuthorizationAppleIDProvider().rx.login(scope: scope, on: window)
            }
    }

    public func login(scope: [ASAuthorization.Scope]? = nil) -> Observable<ASAuthorization> {
        return ASAuthorizationAppleIDProvider().rx.login(scope: scope, on: base.window!)
    }
}
