//
//  VoteWinnerRequestDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 7/28/24.
//

import Foundation


public struct VoteWinnerRequestDTO: Encodable {
    public let date: String
    
    public init(date: String) {
        self.date = date
    }
}
