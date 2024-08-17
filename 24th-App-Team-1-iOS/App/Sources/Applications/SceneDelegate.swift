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
import AllFeature
import Swinject
import SnapKit
import ReactorKit
import RxKakaoSDKAuth
import KakaoSDKAuth
import MessageFeature
import KeychainSwift

public class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    public let injector: Injector = DependencyInjector(container: Container())
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        DependencyContainer.shared.injector.assemble([
            SignInPresentationAssembly(),
            SignUpNamePresentationAssembly(),
            SetUpProfilePresntationAssembly(),
            SignUpClassPresentationAssembly(),
            SignUpGenderPresentationAssembly(),
            SignUpResultPresentationAssembly(),
            SignUpGradePresentationAssembly(),
            SignUpCompletePresentationAssembly(),
            SignUpSchoolPresentationAssembly(),
            VotePresentationAssembly(),
            VoteEffectPresentationAssembly(),
            VoteBeginPresentationAssembly(),
            VoteMainPresentationAssembly(),
            VoteHomePresentationAssembly(),
            VotePagePresentationAssembly(),
            VoteResultPresentationAssembly(),
            VoteCompletePresentationAssembly(),
            VoteInventoryPresentationAssembly(),
            VoteInventoryDetailPresentationAssembly(),
            MessageMainPresentationAssembly(),
            MessagePagePresentationAssembly(),
            MessageHomePresentationAssembly(),
            AllMainPresentationAssembly(),
            AllMainProfilePresentationAssembly(),
            AllMainProfileEditPresentationAssembly(),
            AllMainProfileWebPresentationAssembly(),
            AllMainProfileSettingPresentationAssembly(),
            AllMainProfileAlarmSettingPresentationAssembly(),
            AllMainProfileUserBlockPresentationAssembly(),
            AllMainProfileAccountSettingPresentationAssembly(),
            AllMainProfileResignNotePresentationAssembly(),
            MessageReportPresentationAssembly(),
            AllMainProfileResignPresentationAssembly(),
            DataAssembly(),
            DomainAssembly()
        ])
        
        window = UIWindow(windowScene: scene)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserDidLogin), name: .userDidLogin, object: nil)
        
        let accessToken = KeychainManager.shared.get(type: .accessToken) 
        
        if accessToken?.isEmpty ?? true { // accessToken 값이 없으면 (회원가입 안됨)
            let signInViewController = DependencyContainer.shared.injector.resolve(SignInViewController.self)
            window?.rootViewController = UINavigationController(rootViewController: signInViewController)
            
        } else { // accessToken 값이 있으면 (회원가입이 됨)
            let voteMainViewController = DependencyContainer.shared.injector.resolve(VoteMainViewController.self)
            let voteNavigationContoller = UINavigationController(rootViewController: voteMainViewController)
            
            let messageMainViewReactor = MessageMainViewReactor()
            let messageMainViewController = MessageMainViewController(reactor: messageMainViewReactor)
            let messageNavigationContoller = UINavigationController(rootViewController: messageMainViewController)
            
            let allMainViewController = DependencyContainer.shared.injector.resolve(AllMainViewController.self)
            let allNavigationContoller = UINavigationController(rootViewController: allMainViewController)
        
            let tabbarcontroller = WSTabBarViewController()
            tabbarcontroller.viewControllers = [voteNavigationContoller,messageNavigationContoller, allNavigationContoller]
            window?.rootViewController = tabbarcontroller
        }
        window?.makeKeyAndVisible()
    }
    
    @objc private func handleUserDidLogin() {
        let voteMainViewController = DependencyContainer.shared.injector.resolve(VoteMainViewController.self)
        let voteNavigationContoller = UINavigationController(rootViewController: voteMainViewController)
        
        let messageMainViewReactor = MessageMainViewReactor()
        let messageMainViewController = MessageMainViewController(reactor: messageMainViewReactor)
        let messageNavigationContoller = UINavigationController(rootViewController: messageMainViewController)
        
        let allNavigationContoller = UINavigationController(rootViewController: UIViewController())
        
        let tabbarcontroller = WSTabBarViewController()
        tabbarcontroller.viewControllers = [voteNavigationContoller,messageNavigationContoller, allNavigationContoller]
        window?.rootViewController = tabbarcontroller
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
