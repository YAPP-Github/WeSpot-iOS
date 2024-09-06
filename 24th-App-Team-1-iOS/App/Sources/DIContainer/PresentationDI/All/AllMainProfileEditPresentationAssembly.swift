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
        container.register(ProfileEditViewReactor.self) { (resolver, userProfileEntity: UserProfileEntity, backgroundColor: String) in
            let updateUserProfileUseCase = resolver.resolve(UpdateUserProfileUseCaseProtocol.self)!
            let fetchProfileBackgroundUseCase = resolver.resolve(FetchProfileBackgroundsUseCaseProtocol.self)!
            let fetchProfileImageUseCase = resolver.resolve(FetchProfileImagesUseCaseProtocol.self)!
            
            return ProfileEditViewReactor(
                updateUserProfileUseCase: updateUserProfileUseCase,
                fetchProfileBackgroundUseCase: fetchProfileBackgroundUseCase,
                fetchProfileImageUseCase: fetchProfileImageUseCase,
                userProfileEntity: userProfileEntity,
                backgroundColor: backgroundColor
            )
        }
        
        container.register(ProfileEditViewController.self) { (resolver, userProfileEntity: UserProfileEntity, backgroundColor: String) in
            let reactor = resolver.resolve(ProfileEditViewReactor.self, arguments: userProfileEntity, backgroundColor)!
            
            return ProfileEditViewController(reactor: reactor)
        }
    }
}
