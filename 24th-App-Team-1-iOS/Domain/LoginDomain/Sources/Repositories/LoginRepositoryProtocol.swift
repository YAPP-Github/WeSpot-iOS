//
//  LoginRepositoryProtocol.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import RxSwift

public protocol LoginRepositoryProtocol {
    func createSignUpToken(body: CreateSignUpTokenRequest) -> Single<CreateSignUpOrAccountResponseEntity?> // statusCode에 따라서 신규회원이면 signUp Token 발행 & 기존회원이면 accessToken... 전달
    func createAccount(body: CreateAccountRequest) -> Single<CreateAccountResponseEntity?> //회원가입
    func createRefreshToken(body: CreateRefreshTokenRequest) -> Single<CreateRefreshTokenResponseEntity?> // 토큰 재발행
    func fetchSchoolList(query: SchoolListRequestQuery) -> Single<SchoolListResponseEntity?> // 학교 검색
    func createProfanityCheck(body: CreateProfanityCheckRequest) -> Single<Void>
}
