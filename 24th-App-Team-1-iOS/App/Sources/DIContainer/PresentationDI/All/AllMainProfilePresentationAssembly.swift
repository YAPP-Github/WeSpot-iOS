//
//  AllMainProfilePresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation
import AllFeature
import AllDomain
import CommonDomain

import Swinject


struct AllMainProfilePresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileSettingViewReactor.self) { (resolver, userProfileEntity: UserProfileEntity) in
            let createCheckProfanityUseCase = resolver.resolve(CreateCheckProfanityUseCaseProtocol.self)!
            let updateUserProfileUseCase = resolver.resolve(UpdateUserProfileUseCaseProtocol.self)!
            return ProfileSettingViewReactor(createCheckProfanityUseCase: createCheckProfanityUseCase, updateUserProfileUseCase: updateUserProfileUseCase, userProfileEntity: userProfileEntity)
        }
        
        container.register(ProfileSettingViewController.self) { (resolver, userProfileEntity: UserProfileEntity) in
            let reactor = resolver.resolve(ProfileSettingViewReactor.self, argument: userProfileEntity)!
            
            return ProfileSettingViewController(reactor: reactor)
        }
    }
}
