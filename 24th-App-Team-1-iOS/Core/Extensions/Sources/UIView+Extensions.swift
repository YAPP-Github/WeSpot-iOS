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
    
    func asImage() -> UIImage {
        let render = UIGraphicsImageRenderer(bounds: bounds)
        return render.image { renderContext in
            layer.render(in: renderContext.cgContext)
        }
    }
}

public extension Reactive where Base: UITapGestureRecognizer {
    var tapGesture: ControlEvent<Void> {
        let tapEvent = self.methodInvoked(#selector(Base.touchesBegan(_:with:))).map { _ in }
        return ControlEvent(events: tapEvent)
    }
}

public extension Reactive where Base: UIView {
    var tapGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer()
    }
    
    var tap: ControlEvent<Void> {
        let tapGestureRecognizer = tapGesture
        base.addGestureRecognizer(tapGestureRecognizer)
        
        return tapGestureRecognizer.rx.tapGesture
    }
    
    func swipeGestureRecognizer(direction: UISwipeGestureRecognizer.Direction) -> ControlEvent<UISwipeGestureRecognizer> {
        let gestureRecognizer = UISwipeGestureRecognizer()
        gestureRecognizer.direction = direction
        base.addGestureRecognizer(gestureRecognizer)
        base.isUserInteractionEnabled = true
        
        let source = gestureRecognizer.rx.event
        return ControlEvent(events: source)
    }
}
