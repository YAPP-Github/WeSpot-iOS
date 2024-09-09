//
//  WSToast+Extensions.swift
//  DesignSystem
//
//  Created by eunseou on 7/6/24.
//

import UIKit

public extension UIViewController {
    /// 지정된 이미지와 메시지를 포함한 WSToast를 화면에 보여줍니다.
    ///
    /// - Parameters:
    ///   - image: 토스트에 표시할 이미지 타입.
    ///   - message: 토스트에 표시할 메시지.
    ///   - delay: 토스트가 사라지기까지의 지연 시간 (기본값: 2.0초).
    func showWSToast(image: ToastImagesType, message: String , delay: TimeInterval = 2.0, completionHandler: (() -> Void)? = nil) {
        let toastView = WSToast(image: image, text: message)
        view.addSubview(toastView)
        
        toastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        UIView.animate(withDuration: 0.3,
                       delay: delay,
                       options: .curveEaseOut,
                       animations: {
            toastView.alpha = 0.0
        }, completion: { (isCompleted) in
            toastView.removeFromSuperview()
            completionHandler?()
        })
    }
}
