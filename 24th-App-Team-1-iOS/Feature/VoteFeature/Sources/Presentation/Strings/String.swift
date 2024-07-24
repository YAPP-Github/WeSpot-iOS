//
//  String.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import Foundation

typealias VoteStrings = String.VoteResult
typealias VoteIdentifier = String.VoteResult.Identifier
extension String {
    enum VoteResult {
        enum Identifier { }
    }
}

extension String.VoteResult {
    static let resultText: String = "전체 결과 보기"
    static let voteText: String = "투표하기"
    static let voteDescrptionText: String = "지금 우리 반 투표가 진행 중이에요\n반 친구들에 대해 알려주세요"
    static let voteBannerSubText: String = "다양한 친구들과 더 재밌게 사용해 보세요"
    static let voteBannerMainText: String = "위스팟에 친구 초대하기"
    static let voteHomeButtonText: String = "투표 홈"
    static let voteResultButtonText: String = "투표 결과"
    static let voteMyResultButtonText: String = "내가 받은 투표 보기"
    static let voteCompleteText = "우리 반에서 모르는게생기면물어보고싶은은은은은은은은 친구는?"
    static let voteNoticeText = "친구에게 알려주기"
}

extension String.VoteResult.Identifier {
    static let voteReulstCell = "VoteResultCollectionViewCell"
}
