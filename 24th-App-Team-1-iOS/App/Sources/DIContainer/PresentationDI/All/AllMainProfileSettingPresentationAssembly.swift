//
//  AllMainProfileSettingPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation
import AllFeature

import Swinject


struct AllMainProfileSettingPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileAppSettingViewReactor.self) { _ in
            
            return ProfileAppSettingViewReactor()
        }
        
        container.register(ProfileAppSettingViewController.self) { resovler in
            let reactor = resovler.resolve(ProfileAppSettingViewReactor.self)
            
            return ProfileAppSettingViewController(reactor: reactor)
        }
    }
}
