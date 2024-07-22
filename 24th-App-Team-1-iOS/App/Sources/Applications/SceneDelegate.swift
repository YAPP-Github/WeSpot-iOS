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
import SnapKit
import ReactorKit

class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        //TODO: 임시 코드 입니다 DIContainer 추가 후 변경 예정
        let signInViewReactor = SignInViewReactor()
        let signInViewController = SignInViewController(reactor: signInViewReactor)
        let voteViewReactor = VoteMainViewReactor()
        let voteViewController = VoteMainViewController(reactor: voteViewReactor)
        window?.rootViewController = UINavigationController(rootViewController: voteViewController)
        window?.makeKeyAndVisible()
        
    }
    
}
