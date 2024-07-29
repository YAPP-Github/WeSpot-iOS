//
//  SceneDelegate.swift
//  wespot
//
//  Created by Kim dohyun on 6/27/24.
//

import UIKit
import Util

import LoginFeature
import VoteFeature
import VoteFeature
import VoteDomain
import VoteService
import Swinject
import SnapKit
import ReactorKit

public class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    public let injector: Injector = DependencyInjector(container: Container())
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        DependencyContainer.shared.injector.assemble([
            VotePresentationAssembly(),
            VoteMainPresentationAssembly(),
            VoteHomePresentationAssembly(),
            VotePagePresentationAssembly(),
            VoteResultPresentationAssembly(),
            DataAssembly(),
            DomainAssembly()
        ])
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController =  UINavigationController(rootViewController: DependencyContainer.shared.injector.resolve(VoteMainViewController.self))
        window?.makeKeyAndVisible()
    }
}
