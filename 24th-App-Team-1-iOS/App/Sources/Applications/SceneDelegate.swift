//
//  SceneDelegate.swift
//  wespot
//
//  Created by Kim dohyun on 6/27/24.
//

import UIKit
import Util
import Storage
import DesignSystem

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

        
        if (UserDefaultsManager.shared.accessToken?.isEmpty ?? true) { // accessToken 값이 없으면 (회원가입 안됨)
            let signInViewController = DependencyContainer.shared.injector.resolve(SignInViewController.self)
            window?.rootViewController = UINavigationController(rootViewController: signInViewController)
            
        } else { // accessToken 값이 있으면 (회원가입이 됨)
            let voteMainViewController = DependencyContainer.shared.injector.resolve(VoteMainViewController.self)
            let voteNavigationContoller = UINavigationController(rootViewController: voteMainViewController)
            
            let messageNavigationContoller = UINavigationController(rootViewController: UIViewController())
            
            let allNavigationContoller = UINavigationController(rootViewController: UIViewController())
            
            let tabbarcontroller = WSTabBarViewController()
            tabbarcontroller.viewControllers = [voteNavigationContoller,messageNavigationContoller, allNavigationContoller]
            window?.rootViewController = tabbarcontroller
        }
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
