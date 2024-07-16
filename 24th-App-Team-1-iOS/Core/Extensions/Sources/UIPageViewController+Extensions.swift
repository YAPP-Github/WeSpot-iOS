//
//  UIPageViewController+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/15/24.
//

import UIKit

extension UIPageViewController {
    public var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
