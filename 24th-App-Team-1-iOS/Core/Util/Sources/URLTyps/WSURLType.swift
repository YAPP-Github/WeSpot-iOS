//
//  WSURLType.swift
//  Util
//
//  Created by Kim dohyun on 9/2/24.
//

import Foundation


public enum WSURLType {
    /// 질문지 추가 링크
    case addQuestion
    /// 공식 계정 링크
    case accountOfficial
    /// wespot 카카오톡 채널 링크
    case kakaoChaanel
    /// 스토어 리뷰 링크
    case storeReview
    /// wespot  리뷰 링크
    case wespotReview
    /// wespot 의견 보내기
    case wespotOpinion
    /// wespot 리서치 참여 링크
    case wespotResearch
    /// wespot 메이커스 링크
    case wespotMakers
    /// 개인 정보 변경 신청 링크
    case accountInfo
    /// 학교 추가 링크
    case addSchool
    /// 서비스 이용 약관 링크
    case serviceTerms
    /// 개인 정보 이용 약관 링크
    case privacyTerms
    /// 마케팅 정보 수신 이용 약관
    case marketingTerms
    /// 결제 렌딩 링크
    case payment
    
    
    public var urlString: URL {
        switch self {
        case .addQuestion:
            return URL(string: "https://forms.gle/eiKdpjmwdxzvqm947")!
        case .accountOfficial:
            return URL(string: "https://www.instagram.com/wespot.official/")!
        case .kakaoChaanel:
            return URL(string: "https://pf.kakao.com/_SEDcG")!
        case .storeReview:
            return URL(string: "")!
        case .wespotReview:
            return URL(string: "")!
        case .wespotOpinion:
            return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdObjdp0fJa-rwNNcsf9wGRJwSizxQKDM7t5JHV-n9-5DIO6g/viewform")!
        case .wespotResearch:
            return URL(string :"https://docs.google.com/forms/d/e/1FAIpQLSfkN2b752gRKtFRk9IUreFRacNXnj5jh4tlHWKp0n51IaObyw/viewform")!
        case .wespotMakers:
            return URL(string: "https://www.notion.so/WeSpot-Makers-87e988ab3c9e47f28c141ad1aa663b80")!
        case .accountInfo:
            return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdFlTCYbGL4QDYJlzt8jeeeA-E3ITWIBeYS2B5cAZs2j8wosQ/viewform")!
        case .addSchool:
            return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdwSzjNp4e3FFHLE3DgEpDG13NyLvEpADbGgBjzv9Fni1680Q/viewform?usp=send_form")!
        case .serviceTerms:
            return URL(string: "https://www.notion.so/08f77951919d42cc876a13792f887995?pvs=21")!
        case .privacyTerms:
            return URL(string: "https://www.notion.so/2fa1c3002e14460f91462204b0daefbf")!
        case .marketingTerms:
            return URL(string: "https://www.notion.so/b14afbb4f9194b5881fd198c8538aba8")!
        case .payment:
            return URL(string: "https://payforresult.imweb.me/")!
        }
    }
}
