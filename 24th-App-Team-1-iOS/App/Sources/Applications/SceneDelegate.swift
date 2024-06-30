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
        //TODO: ViewControle 생성 해서 RootViewController로 지정 해주세요
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
    }
    
}


//DEBUG: 디버그용 ViewController 입니다.
final class ViewController: UIViewController {
    
    private let defaultNavigationBar: WSNavigationBar = WSNavigationBar()
    private let centerTextNavigationBar: WSNavigationBar = WSNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(defaultNavigationBar)
        view.addSubview(centerTextNavigationBar)
        view.backgroundColor = .white
        WSLogger.debug(category: ViewLogType.login.description, message: "테스트")
        defaultNavigationBar.setPropertyNavigationBar(property: .default)
        centerTextNavigationBar.setPropertyNavigationBar(property: .center("회원가입"))
        defaultNavigationBar.backgroundColor = .black
        centerTextNavigationBar.backgroundColor = .black
        
        defaultNavigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        centerTextNavigationBar.snp.makeConstraints {
            $0.top.equalTo(defaultNavigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(55)
        }
    }
    
}
