//
//  SceneDelegate.swift
//  wespot
//
//  Created by Kim dohyun on 6/27/24.
//

import UIKit
import Util

import SnapKit
import VoteFeature

class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: VoteMainViewController())
        window?.makeKeyAndVisible()
        
    }
    
}
