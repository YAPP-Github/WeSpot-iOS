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
import NotificationFeature
import Swinject
import SnapKit
import ReactorKit
import RxKakaoSDKAuth
import KakaoSDKAuth
import MessageFeature
import KeychainSwift

public class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    
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
            NotificationPresentationAssembly(),
            DataAssembly(),
            DomainAssembly()
        ])
        
        window = UIWindow(windowScene: scene)
        
        let accessToken = KeychainManager.shared.get(type: .accessToken)
        let refreshToken = KeychainManager.shared.get(type: .refreshToken)
        
        
        if accessToken == nil || refreshToken == nil { // accessToken 값이 없으면 (회원가입 안됨)
            let signInViewController = DependencyContainer.shared.injector.resolve(SignInViewController.self)
            window?.rootViewController = UINavigationController(rootViewController: signInViewController)
            
        } else { // accessToken 값이 있으면 (회원가입이 됨)
            setupMainViewController()
        }
        setupViewControllers()
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

extension SceneDelegate {
    
    //TODO: Coordinator 패턴으로 수정
    private func setupViewControllers() {
        guard let topViewController = self.window?.rootViewController?.topMostViewController() else {
            return
        }
        
        NotificationCenter.default.addObserver(forName: .showProfileImageViewController, object: nil, queue: .main) { [weak self] _ in
            guard let self else { return }
            let setupProfileViewController = DependencyContainer.shared.injector.resolve(SetUpProfileImageViewController.self)
            self.window?.rootViewController = UINavigationController(rootViewController: setupProfileViewController)
        }
        
        NotificationCenter.default.addObserver(forName: .showVoteMainViewController, object: nil, queue: .main) { [weak self] _ in
            guard let self else { return }
            setupMainViewController()
        }
        
        NotificationCenter.default.addObserver(forName: .showSignUpMainViewController, object: nil, queue: .main) { [weak self] notification in
            guard let self = self,
                  let userInfo = notification.userInfo?["isProfileChanged"] as? Bool else { return }
            setupSignUpViewController(isProfileChanged: userInfo)
        }
        
        NotificationCenter.default.addObserver(forName: .showSignInViewController, object: nil, queue: .main) { [weak self] _ in
            guard let self else { return }
            let signInViewController = DependencyContainer.shared.injector.resolve(SignInViewController.self)
            self.window?.rootViewController = UINavigationController(rootViewController: signInViewController)
        }
        
        NotificationCenter.default.addObserver(forName: .showNotifcationViewController, object: nil, queue: .main) { _ in
            let notificationViewController = DependencyContainer.shared.injector.resolve(NotificationViewController.self)
            topViewController.navigationController?.pushViewController(notificationViewController, animated: true)
        }
        
        NotificationCenter.default.addObserver(forName: .showVoteProccessController, object: nil, queue: .main) { _ in
            let voteProcessViewController = DependencyContainer.shared.injector.resolve(VoteProcessViewController.self)
            topViewController.navigationController?.pushViewController(voteProcessViewController, animated: true)
        }
        
        NotificationCenter.default.addObserver(forName: .showVoteInventoryViewController, object: nil, queue: .main) { _ in
            let voteInventoryViewController = DependencyContainer.shared.injector.resolve(VoteInventoryViewController.self)
            topViewController.navigationController?.pushViewController(voteInventoryViewController, animated: true)
        }
        
        NotificationCenter.default.addObserver(forName: .showVoteCompleteViewController, object: nil, queue: .main) { notification in
            
            guard let isCurrnetDate = notification.userInfo?["isCurrnetDate"] as? Bool else { return }
            
            if isCurrnetDate {
                let voteCompleteViewController = DependencyContainer.shared.injector.resolve(VoteCompleteViewController.self)
                topViewController.navigationController?.pushViewController(voteCompleteViewController, animated: true)
            } else {
                let voteEffectViewController = DependencyContainer.shared.injector.resolve(VoteEffectViewController.self)
                topViewController.navigationController?.pushViewController(voteEffectViewController, animated: true)
            }
            
        }
    }
    
}


extension SceneDelegate {
    private func setupSignUpViewController(isProfileChanged: Bool) {
        
        
        let signUpMainViewController = DependencyContainer.shared.injector.resolve(VoteMainViewController.self, argument: isProfileChanged)
        let voteNavigationContoller = UINavigationController(rootViewController: signUpMainViewController)
        
        let messageMainViewController = DependencyContainer.shared.injector.resolve(MessageMainViewController.self)
        let messageNavigationContoller = UINavigationController(rootViewController: messageMainViewController)
        
        let allMainViewController = DependencyContainer.shared.injector.resolve(AllMainViewController.self)
        let allNavigationContoller = UINavigationController(rootViewController: allMainViewController)
        
        
        let tabbarcontroller = WSTabBarViewController()
        tabbarcontroller.viewControllers = [voteNavigationContoller, messageNavigationContoller, allNavigationContoller]
        window?.rootViewController = tabbarcontroller
        
    }
    
    private func setupMainViewController() {
        let voteMainViewController = DependencyContainer.shared.injector.resolve(VoteMainViewController.self)
        let voteNavigationContoller = UINavigationController(rootViewController: voteMainViewController)
        
        let messageMainViewController = DependencyContainer.shared.injector.resolve(MessageMainViewController.self)
        let messageNavigationContoller = UINavigationController(rootViewController: messageMainViewController)
        
        
        let allMainViewController = DependencyContainer.shared.injector.resolve(AllMainViewController.self)
        let allNavigationContoller = UINavigationController(rootViewController: allMainViewController)
    
        let tabbarcontroller = WSTabBarViewController()
        tabbarcontroller.viewControllers = [voteNavigationContoller,messageNavigationContoller, allNavigationContoller]
        window?.rootViewController = tabbarcontroller
    }
}
