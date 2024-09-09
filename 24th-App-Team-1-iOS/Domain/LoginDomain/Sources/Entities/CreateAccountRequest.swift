//
//  CreateAccountRequest.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct ConsentsRequest {
    public var marketing: Bool
    
    public init(marketing: Bool = false) {
        self.marketing = marketing
    }
}

public struct CreateAccountRequest {
    public var name: String
    public var gender: String
    public var schoolId: Int
    public var grade: Int
    public var classNumber: Int
    public var consents: ConsentsRequest
    public var signUpToken: String
    
    public init(name: String = "", gender: String = "", schoolId: Int = 0, grade: Int = 0, classNumber: Int = 0, consents: ConsentsRequest = .init(marketing: false), signUpToken: String = "") {
        self.name = name
        self.gender = gender
        self.schoolId = schoolId
        self.grade = grade
        self.classNumber = classNumber
        self.consents = consents
        self.signUpToken = signUpToken
    }
}
