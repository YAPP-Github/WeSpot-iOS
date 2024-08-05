//
//  SetUpProfilePresntationAssembly.swift
//  wespot
//
//  Created by eunseou on 8/3/24.
//

import Foundation
import LoginFeature
import LoginDomain

import Swinject

struct SetUpProfilePresntationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SetUpProfileImageViewReactor.self) { resolver in

            return SetUpProfileImageViewReactor()
        }
        
        container.register(SetUpProfileImageViewController.self) {  resolver in
            let reactor = resolver.resolve(SetUpProfileImageViewReactor.self)!

            return SetUpProfileImageViewController(reactor: reactor)
        }
    }
}
