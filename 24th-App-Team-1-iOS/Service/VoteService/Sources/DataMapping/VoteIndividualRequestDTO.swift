//
//  VoteReceiveIndividualRequestDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation


public struct VoteIndividualRequestDTO: Encodable {
    public let date: String
    
    public init(date: String) {
        self.date = date
    }
}
