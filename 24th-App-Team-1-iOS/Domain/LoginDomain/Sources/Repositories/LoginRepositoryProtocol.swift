//
//  LoginRepositoryProtocol.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import RxSwift

public protocol LoginRepositoryProtocol {
    func kakaoLogin() -> Single<String>
    func createNewMemberToken(body: CreateSignUpTokenRequest) -> Single<CreateSignUpTokenResponseEntity?> // 신규회원
    func createExistingMember(body: CreateSignUpTokenRequest) -> Single<CreateAccountResponseEntity?> // 기존회원
    func createAccount(body: CreateAccountRequest) -> Single<CreateAccountResponseEntity?> //회원가입
    func createRefreshToken(body: CreateRefreshTokenRequest) -> Single<CreateAccountResponseEntity?> // 토큰 재발행
    func fetchSchoolList(query: SchoolListRequestQuery) -> Single<SchoolListResponseEntity?> // 학교 검색
    func createProfanityCheck(body: CreateProfanityCheckRequest) -> Single<Void>
}
