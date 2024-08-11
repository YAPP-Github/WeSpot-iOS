//
//  MessageReactiveExtensions.swift
//  LoginFeature
//
//  Created by eunseou on 8/11/24.
//

import UIKit
import DesignSystem

import RxSwift
import RxCocoa

extension Reactive where Base: WSBanner {
    var reservedMessages: Binder<Int> {
        return Binder(self.base) { view, count in
            if count == 3 {
                view.setTitleText("예약 중인 쪽지 \(count)개")
            } else {
                view.setTitleText("예약 중인 쪽지 \(count)개")
                view.setSubTitleText("\(3 - count)개의 쪽지를 더 보낼 수 있어요")
            }
        }
    }
}

extension Reactive where Base: MessageCardView {
    var isSendAllowed: Binder<Bool> {
        return Binder(self.base) { view, isAllowed in
            view.setSendAllowed(isAllowed)
        }
    }
}
