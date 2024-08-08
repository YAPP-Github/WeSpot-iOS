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
    static let voteCompleteText = "우리 반에서 모르는게생기면\n물어보고싶은은은은은은은은 친구는?"
    static let voteNoticeText = "친구에게 알려주기"
    static let voteInviteButtonText: String = "친구 초대하기"
    static let voteBeginInfoText: String = "투표할 수 있는\n1학년 6반 친구들이 부족해요"
    static let voteProcessTopText: String = "제보하기"
    static let voteReportAlertText: String = "우리 반 친구가 아니에요"
    static let voteChoiceAlertText: String = "더 다양한 선택지를 원해요"
    static let voteCancelAlertText: String = "취소"
    static let voteModalConfirmText: String = "네 아니에요"
    static let voteModalCancelText: String = "닫기"
    static let voteModalTitleText: String = "우리 반 친구가 아닌가요?"
    static let voteModalMessageText: String = "우리 반 친구를 잘못 신고한 것이 확인될 경우\n서비스 이용에 제한이 생길 수 있어요"
    static let voteToastText: String = "제보 접수 완료"
    static let voteResultText: String = "투표 완료하고 결과 확인하기"
    static let voteRealTimeButtonText: String = "실시간 투표"
    static let voteLastTimeButtonText: String = "지난 투표"
}

extension String.VoteResult.Identifier {
    static let voteResultCell = "VoteResultCollectionViewCell"
    static let voteProcessCell = "VoteProcessTableViewCell"
    static let voteHighCell = "VoteHighCollectionViewCell"
    static let voteLowCell = "VoteLowCollectionViewCell"
    static let voteAllCell = "VoteAllCollectionViewCell"
    static let voteEmptyCell = "VoteEmptyCollectionViewCell"
    static let voteReceiveCell = "VoteReceiveTableViewCell"
    static let voteSentCell = "VoteSentTableViewCell"
}
