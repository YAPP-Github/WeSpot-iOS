//
//  MessageExtraPresentationAssembly.swift
//  wespot
//
//  Created by eunseou on 8/11/24.
//

import Foundation
import MessageFeature
import MessageDomain

import Swinject

struct MessageReportPresentationAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(MessageReportViewReactor.self) { resolver in
            return MessageReportViewReactor()
        }
        
        container.register(MessageReportViewController.self) { resolver in
            let reactor = resolver.resolve(MessageReportViewReactor.self)!
            
            return MessageReportViewController(reactor: reactor)
        }
        
    }
}
