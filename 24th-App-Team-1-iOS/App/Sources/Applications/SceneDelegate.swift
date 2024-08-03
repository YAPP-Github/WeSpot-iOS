//
//  SceneDelegate.swift
//  wespot
//
//  Created by Kim dohyun on 6/27/24.
//

import UIKit
import Util

import LoginFeature
import LoginDomain
import LoginService
import VoteFeature
import VoteDomain
import VoteService
import Swinject
import SnapKit
import ReactorKit
import RxKakaoSDKAuth
import KakaoSDKAuth

public class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    public let injector: Injector = DependencyInjector(container: Container())
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        DependencyContainer.shared.injector.assemble([
            SignInPresentationAssembly(),
            SignUpNamePresentationAssembly(),
            SignUpSchoolPresentationAssembly(),
            VotePresentationAssembly(),
            VoteBeginPresentationAssembly(),
            VoteMainPresentationAssembly(),
            VoteHomePresentationAssembly(),
            VotePagePresentationAssembly(),
            VoteResultPresentationAssembly(),
            VoteCompletePresentationAssembly(),
            DataAssembly(),
            DomainAssembly()
        ])
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController =  UINavigationController(rootViewController: DependencyContainer.shared.injector.resolve(SignUpSchoolViewController.self))
        window?.makeKeyAndVisible()
    }
    
    // kakao login
    public func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.rx.handleOpenUrl(url: url)
            }
        }
    }
    
}
