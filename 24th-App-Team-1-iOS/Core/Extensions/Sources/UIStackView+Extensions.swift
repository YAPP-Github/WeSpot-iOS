//
//  UIStackView+Extensions.swift
//  Extensions
//
//  Created by eunseou on 7/20/24.
//

import UIKit

public extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
