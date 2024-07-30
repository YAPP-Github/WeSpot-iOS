//
//  UIView+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/1/24.
//

import UIKit

import RxSwift
import RxCocoa

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}

public extension Reactive where Base: UIView {
    func swipeGestureRecognizer(direction: UISwipeGestureRecognizer.Direction) -> ControlEvent<UISwipeGestureRecognizer> {
        let gestureRecognizer = UISwipeGestureRecognizer()
        gestureRecognizer.direction = direction
        base.addGestureRecognizer(gestureRecognizer)
        base.isUserInteractionEnabled = true
        
        let source = gestureRecognizer.rx.event
        return ControlEvent(events: source)
    }
}
