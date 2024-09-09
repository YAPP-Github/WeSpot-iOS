//
//  LoginRepositoryProtocol.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import RxSwift

public protocol LoginRepositoryProtocol {
    func createNewMemberToken(body: CreateSignUpTokenRequest) -> Single<CreateSignUpTokenResponseEntity?> // 신규회원
    func createExistingMember(body: CreateSignUpTokenRequest) -> Single<Bool> // 기존회원
    func createAccount(body: CreateAccountRequest) -> Single<CreateAccountResponseEntity?> //회원가입
    func fetchSchoolList(query: SchoolListRequestQuery) -> Single<SchoolListResponseEntity?> // 학교 검색
}
