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
            .decodeMap(CreateSignUpTokenResponseDTO.self)
            .logErrorIfDetected(category: Network.error)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func createExistingMember(body: CreateSignUpTokenRequest) -> Single<Bool> {
        let body = CreateSignUpTokenRequestDTO(socialType: body.socialType, authorizationCode: body.authorizationCode, identityToken: body.identityToken, fcmToken: body.fcmToken)
        let endPoint = LoginEndPoint.createSocialLogin(body)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .map { _ in true }
            .catchAndReturn(false)
            .logErrorIfDetected(category: Network.error)
            .asSingle()
    }
    
    
    
    public func createAccount(body: CreateAccountRequest) -> Single<CreateAccountResponseEntity?> {
        let consents = ConsentsRequestDTO(marketing: body.consents.marketing)
        let body = CreateAccountRequestDTO(name: body.name, gender: body.gender.uppercased(), schoolId: body.schoolId, grade: body.grade, classNumber: body.classNumber, consents: consents, signUpToken: body.signUpToken)
        let endPoint = LoginEndPoint.createAccount(body)
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .decodeMap(CreateAccountResponseDTO.self)
            .logErrorIfDetected(category: Network.error)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func fetchSchoolList(query: SchoolListRequestQuery) -> Single<SchoolListResponseEntity?> {
        let query = SchoolListRequestDTO(name: query.name, cursorId: query.cursorId)
        let endPoint = LoginEndPoint.fetchSchoolList(query)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(SchoolListResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
}
