//
//  LoginRepositoryProtocol.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import RxSwift

public protocol LoginRepositoryProtocol {
    func createSignUpToken(body: CreateSignUpTokenRequest) -> Single<CreateSignUpTokenResponseEntity?> // 신규회원 signUp Token 발행
    func createAccount(body: CreateAccountRequest) -> Single<CreateAccountResponseEntity?> //회원가입
    func createRefreshToken(body: CreateRefreshTokenRequest) -> Single<CreateRefreshTokenResponseEntity?> // 토큰 재발행
    func fetchSchoolList(query: SchoolListRequestQuery) -> Single<SchoolListResponseEntity?> // 학교 검색
}
