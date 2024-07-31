//
//  DataAssembly.swift
//  wespot
//
//  Created by Kim dohyun on 7/23/24.
//

import Foundation
import LoginDomain
import LoginService
import VoteDomain
import VoteService
import Networking

import Swinject


struct DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(VoteRepositoryProtocol.self) { _ in
            return VoteRepository()
        }
        
        container.register(LoginRepositoryProtocol.self) { _ in
            return LoginRepository()
        }
    }
}
