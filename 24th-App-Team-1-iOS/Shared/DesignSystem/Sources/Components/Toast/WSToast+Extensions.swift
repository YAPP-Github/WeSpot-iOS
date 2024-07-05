//
//  WSToast+Extensions.swift
//  DesignSystem
//
//  Created by eunseou on 7/6/24.
//

import UIKit

public extension UIViewController {
    // WSToast 보여주는 메서드
    func showWSToast(image: ToastImagesType, message: String) {
        let toastView = WSToast(image: image, text: message)
        view.addSubview(toastView)
        
        toastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        UIView.animate(withDuration: 0.3,
                       delay: 2,
                       options: .curveEaseOut,
                       animations: {
            toastView.alpha = 0.0
        }, completion: { (isCompleted) in
            toastView.removeFromSuperview()
        })
    }
}
