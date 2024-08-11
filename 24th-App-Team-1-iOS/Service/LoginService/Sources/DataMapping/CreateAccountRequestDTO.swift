//
//  CreateAccountRequestDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct CreateAccountRequestDTO: Encodable {
    public let name: String?
    public let gender: String?
    public let schoolId: Int?
    public let grade: Int?
    public let classNumber: Int?
    public let consents: ConsentsRequestDTO?
    public let signUpToken: String?
    
    public init(name: String?, gender: String?, schoolId: Int?, grade: Int?, classNumber: Int?, consents: ConsentsRequestDTO?, signUpToken: String?) {
        self.name = name
        self.gender = gender
        self.schoolId = schoolId
        self.grade = grade
        self.classNumber = classNumber
        self.consents = consents
        self.signUpToken = signUpToken
    }
}

public struct ConsentsRequestDTO: Encodable {
    public let marketing: Bool?
    
    public init(marketing: Bool?) {
        self.marketing = marketing
    }
}
