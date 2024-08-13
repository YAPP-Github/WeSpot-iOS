//
//  ProfileRepositoryProtocol.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation

import RxSwift

public protocol ProfileRepositoryProtocol {
    func fetchUserProfileItems() -> Single<UserProfileEntity?>
    func updateUserProfileItem(body: UpdateUserProfileRequest) -> Single<Bool>
}
