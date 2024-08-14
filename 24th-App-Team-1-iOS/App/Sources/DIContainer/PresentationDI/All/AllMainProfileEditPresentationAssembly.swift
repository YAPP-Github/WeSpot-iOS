//
//  AllMainProfileEditPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/13/24.
//

import Foundation
import AllFeature
import CommonDomain
import AllDomain

import Swinject

struct AllMainProfileEditPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileEditViewReactor.self) { (resolver, userProfileEntity: UserProfileEntity) in
            let updateUserProfileUseCase = resolver.resolve(UpdateUserProfileUseCaseProtocol.self)!
            let fetchProfileBackgroundUseCase = resolver.resolve(FetchProfileBackgroundsUseCaseProtocol.self)!
            let fetchProfileImageUseCase = resolver.resolve(FetchProfileImagesUseCaseProtocol.self)!
            
            return ProfileEditViewReactor(
                updateUserProfileUseCase: updateUserProfileUseCase,
                fetchProfileBackgroundUseCase: fetchProfileBackgroundUseCase,
                fetchProfileImageUseCase: fetchProfileImageUseCase,
                userProfileEntity: userProfileEntity
            )
        }
        
        container.register(ProfileEditViewController.self) { (resolver, userProfileEntity: UserProfileEntity) in
            let reactor = resolver.resolve(ProfileEditViewReactor.self, argument: userProfileEntity)!
            
            return ProfileEditViewController(reactor: reactor)
        }
    }
}
