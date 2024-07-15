//
//  SceneDelegate.swift
//  wespot
//
//  Created by Kim dohyun on 6/27/24.
//

import UIKit
import Util

import LoginFeature
import SnapKit
import ReactorKit


class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        //TODO: ViewControle 생성 해서 RootViewController로 지정 해주세요
        let signInViewReactor = SignInViewReactor()
        let signInViewController = SignInViewController(reactor: signInViewReactor)
        window?.rootViewController = UINavigationController(rootViewController: signInViewController)
        window?.makeKeyAndVisible()
        
    }
    
}
