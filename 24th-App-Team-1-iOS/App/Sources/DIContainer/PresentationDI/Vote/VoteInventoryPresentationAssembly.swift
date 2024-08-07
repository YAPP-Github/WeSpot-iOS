//
//  VoteInventoryPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation
import VoteFeature

import Swinject



struct VoteInventoryPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(VoteInventoryViewReactor.self) { _ in
            return VoteInventoryViewReactor()
        }
        
        container.register(VoteInventoryViewController.self) { resolver in
            
            let reactor = container.resolve(VoteInventoryViewReactor.self)!
            
            return VoteInventoryViewController(reactor: reactor)
        }
    }
}
