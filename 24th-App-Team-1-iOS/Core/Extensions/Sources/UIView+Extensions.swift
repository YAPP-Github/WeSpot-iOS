//
//  UIView+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/1/24.
//

import UIKit


public extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
