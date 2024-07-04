//
//  WSBanner+Extensions.swift
//  DesignSystem
//
//  Created by eunseou on 7/5/24.
//

import Foundation

import RxSwift
import RxCocoa

//MARK: Reactive+Extensions
extension Reactive where Base: WSBanner {
    public var arrowButtonTap: ControlEvent<Void> {
        let source = base.arrowButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .withUnretained(base)
            .map { _ in } // Void로 변경
        
        return ControlEvent(events: source)
    }
}
