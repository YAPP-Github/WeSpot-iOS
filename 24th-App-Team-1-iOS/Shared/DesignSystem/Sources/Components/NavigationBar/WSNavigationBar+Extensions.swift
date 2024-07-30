//
//  WSNavigationBar+Extensions.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/1/24.
//

import Foundation

import RxCocoa
import RxSwift


//MARK: Reactive+Extensions
extension Reactive where Base: WSNavigationBar {
    public var leftBarButtonItem: ControlEvent<WSNavigationType?> {
        let source = base.leftBarButton.rx.tap
            .withUnretained(base)
            .map { $0.0.navigationProperty }
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
        
        return ControlEvent(events: source)
    }
}
