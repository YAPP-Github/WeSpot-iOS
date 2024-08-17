//
//  AllMainProfileResignNotePresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/17/24.
//

import Foundation
import AllFeature

import Swinject

struct AllMainProfileResignNotePresentationAssembly: Assembly {
    
    
    func assemble(container: Container) {
        container.register(ProfileResignNoteViewReactor.self) { _ in
            return ProfileResignNoteViewReactor()
        }
        
        container.register(ProfileResignNoteViewController.self) { resolver in
            let reactor = resolver.resolve(ProfileResignNoteViewReactor.self)!
            return ProfileResignNoteViewController(reactor: reactor)
        }
    }
}
