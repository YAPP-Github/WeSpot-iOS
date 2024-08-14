//
//  AllMainProfilePresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation
import AllFeature
import CommonDomain

import Swinject


struct AllMainProfilePresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileSettingViewReactor.self) { resolver in
            let createCheckProfanityUseCase = resolver.resolve(CreateCheckProfanityUseCaseProtocol.self)!
            return ProfileSettingViewReactor(createCheckProfanityUseCase: createCheckProfanityUseCase)
        }
        
        container.register(ProfileSettingViewController.self) { resolver in
            let reactor = resolver.resolve(ProfileSettingViewReactor.self)!
            
            return ProfileSettingViewController(reactor: reactor)
        }
    }
}
