//
//  WSLabel.swift
//  DesignSystem
//
//  Created by eunseou on 6/28/24.
//

import UIKit

class WSLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 텍스트와 WSFont를 받아 초기화
    /// - Parameters:
    ///   - text: 설정할 텍스트입니다.
    ///   - wsFont: 사용할 WSFont입니다. ex) Header01, Body01
    init(text: String?, wsFont: WSFont) {
        super.init(frame: .zero)
        self.text = text
        font(wsFont)
    }
    
    /// WSFont만 받아 초기화
    /// - Parameters:
    ///   - wsFont: 사용할 WSFont입니다.  ex) Header01, Body01
    init(wsFont: WSFont) {
        super.init(frame: .zero)
        font(wsFont)
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
        
        let baselineOffset = (lineHeight - wsFont.size) / 2
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .baselineOffset: baselineOffset
        ]
        
        return NSAttributedString(string: self.text ?? "", attributes: attributes)
    }
}
