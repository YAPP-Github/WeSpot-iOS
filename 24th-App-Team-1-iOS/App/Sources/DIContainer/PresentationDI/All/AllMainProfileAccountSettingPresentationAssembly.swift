//
//  AllMainProfileAccountSettingPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation
import AllFeature

import Swinject


struct AllMainProfileAccountSettingPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileAccountSettingViewReactor.self) { _ in
            return ProfileAccountSettingViewReactor()
        }
        
        container.register(ProfileAccountSettingViewController.self) { resolver in
            let reactor = resolver.resolve(ProfileAccountSettingViewReactor.self)
            
            return ProfileAccountSettingViewController(reactor: reactor)
        }
    }
}
