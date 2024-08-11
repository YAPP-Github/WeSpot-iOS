//
//  AllMainPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/11/24.
//

import Foundation
import AllFeature

import Swinject


struct AllMainPresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AllMainViewReactor.self) { _ in
            return AllMainViewReactor()
        }
        
        container.register(AllMainViewController.self) { resolver in
            let reactor = resolver.resolve(AllMainViewReactor.self)!
            
            return AllMainViewController(reactor: reactor)
        }
    }
}
