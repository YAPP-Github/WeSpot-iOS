//
//  AllMainProfileAlarmSettingPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation
import AllFeature

import Swinject

struct AllMainProfileAlarmSettingPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileAlarmSettingViewReactor.self) { _ in
            return ProfileAlarmSettingViewReactor()
        }
        
        container.register(ProfileAlarmSettingViewController.self) { resolver in
            let reactor = resolver.resolve(ProfileAlarmSettingViewReactor.self)
            
            return ProfileAlarmSettingViewController(reactor: reactor)
        }
    }
}
