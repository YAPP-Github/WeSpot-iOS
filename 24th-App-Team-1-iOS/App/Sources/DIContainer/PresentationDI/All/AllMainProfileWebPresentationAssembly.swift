//
//  AllMainProfileWebPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/14/24.
//

import Foundation
import AllFeature

import Swinject


struct AllMainProfileWebPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileWebViewReactor.self) { (_, contentURL: URL) in
            return ProfileWebViewReactor(contentURL: contentURL)
        }
        
        container.register(ProfileWebViewController.self) { (resovler, contentURL: URL) in
            let reactor = resovler.resolve(ProfileWebViewReactor.self, argument: contentURL)
            
            return ProfileWebViewController(reactor: reactor)
        }
    }
    
}
