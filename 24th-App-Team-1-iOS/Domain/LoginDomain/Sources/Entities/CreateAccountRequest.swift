//
//  CreateAccountRequest.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct ConsentsRequest {
    public let marketing: Bool
    
    public init(marketing: Bool) {
        self.marketing = marketing
    }
}

public struct CreateAccountRequest {
    public let name: String
    public let gender: String
    public let schoolId: Int
    public let grade: Int
    public let classNumber: Int
    public let consents: ConsentsRequest
    public let signUpToken: String
    
    public init(name: String, gender: String, schoolId: Int, grade: Int, classNumber: Int, consents: ConsentsRequest, signUpToken: String) {
        self.name = name
        self.gender = gender
        self.schoolId = schoolId
        self.grade = grade
        self.classNumber = classNumber
        self.consents = consents
        self.signUpToken = signUpToken
    }
}
