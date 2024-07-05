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
}
