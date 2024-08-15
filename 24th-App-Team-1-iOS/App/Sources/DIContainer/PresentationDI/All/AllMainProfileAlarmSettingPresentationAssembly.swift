//
//  AllMainProfileAlarmSettingPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation
import AllFeature
import AllDomain

import Swinject

struct AllMainProfileAlarmSettingPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileAlarmSettingViewReactor.self) { resolver in
            let fetchUserAlarmUseCase = resolver.resolve(FetchUserAlarmSettingUseCaseProtocol.self)!
            
            return ProfileAlarmSettingViewReactor(fetchUserAlarmUseCase: fetchUserAlarmUseCase)
        }
        
        container.register(ProfileAlarmSettingViewController.self) { resolver in
            let reactor = resolver.resolve(ProfileAlarmSettingViewReactor.self)
            
            return ProfileAlarmSettingViewController(reactor: reactor)
        }
    }
}
