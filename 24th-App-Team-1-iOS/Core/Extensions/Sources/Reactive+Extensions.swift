//
//  Reactive+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/23/24.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    public var viewWillAppear: ControlEvent<Bool> {
        let event = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: event)
    }
    
    public var viewDidDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
      }
}

