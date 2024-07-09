//
//  WSAlertActionProperty.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/9/24.
//

import Foundation

//MARK: WSAlertView의 액션을 담당하는 모듈
public struct WSAlertActionProperty {
    var confirmAction: (() -> Void)?
    var cancelAction: (() -> Void)?
}
