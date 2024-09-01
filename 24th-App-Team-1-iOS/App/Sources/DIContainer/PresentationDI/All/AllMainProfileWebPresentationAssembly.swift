//
//  AllMainProfileWebPresentationAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 8/14/24.
//

import Foundation
import DesignSystem

import Swinject


struct AllMainProfileWebPresentationAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(WSWebViewReactor.self) { (_, contentURL: URL) in
            return WSWebViewReactor(contentURL: contentURL)
        }
        
        container.register(WSWebViewController.self) { (resovler, contentURL: URL) in
            let reactor = resovler.resolve(WSWebViewReactor.self, argument: contentURL)
            
            return WSWebViewController(reactor: reactor)
        }
    }
    
}
