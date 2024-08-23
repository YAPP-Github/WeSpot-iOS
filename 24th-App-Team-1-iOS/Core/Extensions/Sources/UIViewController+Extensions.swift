//
//  UIViewController+Extensions.swift
//  Extensions
//
//  Created by eunseou on 7/2/24.
//


import UIKit

public extension UIViewController {
    
    // 뷰 컨트롤러의 뷰에 탭 제스처 인식기를 추가하여, 뷰를 탭하면 키보드를 숨깁니다.
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func shareToInstagramStory(to view: UIView) {
        guard let url = URL(string: "instagram-stories://share?source_application="+"123444") else { return }
        
        view.setNeedsLayout()
        let image = view.asImage()
        var imageData = image.pngData()
        
        let pastboardItems: [String: Any] = ["com.instagram.sharedSticker.stickerImage": imageData]
        let pastboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)]
        
        UIPasteboard.general.setItems([pastboardItems], options: pastboardOptions)
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            guard let instagramURL = URL(string: "https://apps.apple.com/kr/app/instagram/id389801252") else {
                return
            }
            UIApplication.shared.open(instagramURL)
        }
    }
    
    func shareToKakaoTalk() {
        //TODO: 앱 설치 링크로 변경 및 문구 변경
        let shareURL = URL(string: "https://apps.apple.com/kr/app/instagram/id389801252")!
        
        
        let shareViewController = UIActivityViewController(activityItems: [WSURLItemSource(wespotAppURL: shareURL)], applicationActivities: nil)
        shareViewController.excludedActivityTypes = [.copyToPasteboard, .assignToContact]
        self.present(shareViewController, animated: true)
    }
    
    func topMostViewController() -> UIViewController? {
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.topMostViewController()
        }
        if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.topMostViewController()
        }
        return self
    }
}
