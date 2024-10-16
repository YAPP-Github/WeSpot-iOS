//
//  ProfileRepositoryProtocol.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation

import RxSwift

public protocol ProfileRepositoryProtocol {
    func fetchUserAlarmItems() -> Single<UserAlarmEntity?>
    func updateUserAlarmItem(body: UpdateUserProfileAlarmRequest) -> Single<Bool>
    func fetchUserBlockItems(query: UserBlockRequestQuery) -> Single<UserBlockEntity?>
    func updateUserBlockItem(path: String) -> Single<Bool>
    func createUserResignItem() -> Single<Bool>
}
