//
//  SceneDelegate.swift
//  wespot
//
//  Created by Kim dohyun on 6/27/24.
//

import UIKit
import Util

import DesignSystem
import SnapKit


class SceneDelegate: UIResponder, UISceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = ViewController()
        //TODO: ViewControle 생성 해서 RootViewController로 지정 해주세요
        window?.makeKeyAndVisible()
        
    }
    
}


final class ViewController: UIViewController {

    private let wsButton: WSButton = WSButton(wsButtonType: .default).setupButton(text: "메이플 메소")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(wsButton)
        configure()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray700.color
    }
    
    
    private func configure() {
        wsButton.snp.makeConstraints {
            $0.width.equalTo(355)
            $0.height.equalTo(72)
            $0.center.equalToSuperview()
        }
    }
    
}
