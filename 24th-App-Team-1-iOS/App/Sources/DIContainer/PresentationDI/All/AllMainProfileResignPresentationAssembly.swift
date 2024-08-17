//
//  AllMainProfileResignPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/17/24.
//

import Foundation
import AllFeature

import Swinject

struct AllMainProfileResignPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileResignBottomSheetVieReactor.self) { _ in
            return ProfileResignBottomSheetVieReactor()
        }
        
        container.register(ProfileResignBottomSheetView.self) { resolver in
            let reactor = resolver.resolve(ProfileResignBottomSheetVieReactor.self)!
            return ProfileResignBottomSheetView(reactor: reactor)
        }
        
        
        container.register(ProfileResignViewReactor.self) { _ in
            return ProfileResignViewReactor()
        }
        
        container.register(ProfileResignViewController.self) { resolver in
            let reactor = resolver.resolve(ProfileResignViewReactor.self)!
            return ProfileResignViewController(reactor: reactor)
        }
    }
}
