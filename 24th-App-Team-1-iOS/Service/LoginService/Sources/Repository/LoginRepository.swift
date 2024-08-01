//
//  LoginRepository.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import Networking
import LoginDomain
import Util
import Extensions

import RxSwift
import RxCocoa

public final class LoginRepository: LoginRepositoryProtocol {
    
    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    public init() { }

    
    public func createNewMemberToken(body: CreateSignUpTokenRequest) -> Single<CreateSignUpTokenResponseEntity?> {
        let body = CreateSignUpTokenRequestDTO(socialType: body.socialType, authorizationCode: body.authorizationCode, identityToken: body.identityToken, fcmToken: body.fcmToken)
        let endPoint = LoginEndPoint.createSocialLogin(body)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(CreateSignUpTokenResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func createExistingMember(body: CreateSignUpTokenRequest) -> Single<CreateAccountResponseEntity?> {
        let body = CreateSignUpTokenRequestDTO(socialType: body.socialType, authorizationCode: body.authorizationCode, identityToken: body.identityToken, fcmToken: body.fcmToken)
        let endPoint = LoginEndPoint.createSocialLogin(body)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(CreateAccountResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    

    
    public func createAccount(body: CreateAccountRequest) -> Single<CreateAccountResponseEntity?> {
        let consents = ConsentsRequestDTO(marketing: body.consents.marketing)
        let body = CreateAccountRequestDTO(name: body.name, gender: body.gender, schoolId: body.schoolId, grade: body.grade, classNumber: body.classNumber, consents: consents, signUpToken: body.signUpToken)
        let endPoint = LoginEndPoint.createAccount(body)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(CreateAccountResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func createRefreshToken(body: CreateRefreshTokenRequest) -> Single<CreateAccountResponseEntity?> {
        let body = CreateRefreshTokenRequestDTO(token: body.token)
        let endPoint = LoginEndPoint.createRefreshToken(body)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(CreateAccountResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func fetchSchoolList(query: SchoolListRequestQuery) -> Single<SchoolListResponseEntity?> {
        let query = SchoolListRequestDTO(name: query.name)
        let endPoint = LoginEndPoint.fetchSchoolList(query)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(SchoolListResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func createProfanityCheck(body: CreateProfanityCheckRequest) -> Single<Void> {
        let query = CreateProfanityCheckRequestDTO(message: body.message)
        let endPoint = LoginEndPoint.createProfanityCheck(query)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .asSingle()
            .map { _ in return Void() }
    }
}
