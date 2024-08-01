//
//  ASAuthorizationAppleID+Extensions.swift
//  Extensions
//
//  Created by eunseou on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import AuthenticationServices  // Apple ID 인증을 위한 프레임워크

// ASAuthorizationAppleIDProvider의 Reactive 확장
extension Reactive where Base: ASAuthorizationAppleIDProvider {
    
    // Apple ID 로그인 요청을 수행하는 함수
    public func login(scope: [ASAuthorization.Scope]? = nil, on window: UIWindow) -> Observable<ASAuthorization> {
        
        // Apple ID 인증 요청 생성
        let request = base.createRequest()
        request.requestedScopes = scope // 요청 범위 설정

        // 인증 컨트롤러 생성
        let controller = ASAuthorizationController(authorizationRequests: [request])

        // 인증 컨트롤러 프록시 생성 및 설정
        let proxy = ASAuthorizationControllerProxy.proxy(for: controller)
        proxy.presentationWindow = window

        // 컨트롤러의 프레젠테이션 컨텍스트 제공자 설정
        controller.presentationContextProvider = proxy
        controller.performRequests() // 인증 요청 수행

        // 인증 완료 이벤트 반환
        return proxy.didComplete
    }
}

// ASAuthorizationAppleIDButton의 Reactive 확장
extension Reactive where Base: ASAuthorizationAppleIDButton {
    
    // Apple ID 버튼이 눌렸을 때 로그인 요청을 수행하는 함수
    public func loginOnTap(scope: [ASAuthorization.Scope]? = nil) -> Observable<ASAuthorization> {
        return controlEvent(.touchUpInside) // 버튼 터치 이벤트 감지
            .compactMap{ _ in base.window! }
            .flatMap { window in
                // 터치 이벤트가 발생하면 Apple ID 로그인 요청 수행
                ASAuthorizationAppleIDProvider().rx.login(scope: scope, on: window)
            }
    }

    // 명시적으로 로그인 요청을 수행하는 함수
    public func login(scope: [ASAuthorization.Scope]? = nil) -> Observable<ASAuthorization> {
        return ASAuthorizationAppleIDProvider().rx.login(scope: scope, on: base.window!)
    }
}
