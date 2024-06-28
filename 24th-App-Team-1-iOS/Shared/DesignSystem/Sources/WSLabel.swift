//
//  WSLabel.swift
//  DesignSystem
//
//  Created by eunseou on 6/28/24.
//

import UIKit

public class WSLabel: UILabel {
    
    /// 텍스트와 WSFont를 받아 초기화
    /// - Parameters:
    ///   - text: 설정할 텍스트입니다. 기본값은 nil입니다.
    ///   - wsFont: 사용할 WSFont입니다. ex) Header01, Body01
    ///   - textAlignment: 텍스트 정렬 방식입니다. default는 .left
    public init(wsFont: WSFont, text: String? = nil, textAlignment: NSTextAlignment = .left) {
        super.init(frame: .zero)
        self.text = text
        font(wsFont)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// WSFont를 적용
    /// - Parameters:
    ///   - wsFont: 적용할 WSFont입니다.  ex) Header01, Body01
    func font(_ wsFont: WSFont) {
        self.font = wsFont.font()
        self.numberOfLines = 0
        self.attributedText = attributedText(with: wsFont)
    }
    
    /// 주어진 WSFont로 NSAttributedString을 생성
    /// - Parameters:
    ///   - wsFont: 사용할 WSFont입니다.  ex) Header01, Body01
    /// - Returns: 생성된 NSAttributedString입니다.
    private func attributedText(with wsFont: WSFont) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        let lineHeight = wsFont.size * wsFont.lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.lineHeightMultiple = wsFont.lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        // 텍스트 베이스라인 오프셋 계산
        let baselineOffset = (lineHeight - wsFont.size) / 2
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle, // 문단 스타일 설정
            .baselineOffset: baselineOffset // 베이스라인 오프셋 설정
        ]
        
        return NSAttributedString(string: self.text ?? "", attributes: attributes)
    }
}
