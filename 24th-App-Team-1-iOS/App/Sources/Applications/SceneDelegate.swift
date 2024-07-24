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

class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    private let injector: Injector = DependencyInjector(container: Container())
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        injector.assemble([
            VotePresentationAssembly(),
            DataAssembly(),
            DomainAssembly()
        ])
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = injector.resolve(VoteMainViewController.self)
        window?.makeKeyAndVisible()
    }
}
