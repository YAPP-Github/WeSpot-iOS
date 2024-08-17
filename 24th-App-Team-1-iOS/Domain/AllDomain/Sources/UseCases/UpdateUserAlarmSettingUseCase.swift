//
//  UpdateUserAlarmSettingUseCase.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation

import RxSwift
import RxCocoa

public protocol UpdateUserAlarmSettingUseCaseProtocol {
    func execute(body: UpdateUserProfileAlarmRequest) -> Single<Bool>
}

public final class UpdateUserAlarmSettingUseCase: UpdateUserAlarmSettingUseCaseProtocol {
    
    private let profileRepository: ProfileRepositoryProtocol
    
    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
    
    public func execute(body: UpdateUserProfileAlarmRequest) -> Single<Bool> {
        return profileRepository.updateUserAlarmItem(body: body)
    }
}
