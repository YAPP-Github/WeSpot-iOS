//
//  FetchUserAlarmSettingUseCase.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol FetchUserAlarmSettingUseCaseProtocol {
    func execute() -> Single<UserAlarmEntity?>
}


public final class FetchUserAlarmSettingUseCase: FetchUserAlarmSettingUseCaseProtocol {
    
    private let profileRepository: ProfileRepositoryProtocol
    
    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
    
    public func execute() -> Single<UserAlarmEntity?> {
        return profileRepository.fetchUserAlarmItems()
    }
}
