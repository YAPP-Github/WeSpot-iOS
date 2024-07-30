//
//  NSAttributedString+Extensions.swift
//  Extensions
//
//  Created by eunseou on 7/11/24.
//

import UIKit


public extension NSAttributedString {
 
    /// 주어진 텍스트, 폰트, 자간 및 텍스트 정렬 방식으로 NSAttributedString을 생성
    /// - Parameters:
    ///   - text: 설정할 텍스트입니다.
    ///   - font: 사용할 UIFont입니다.
    ///   - lineHeight: 라인 높이 배수입니다.
    ///   - textAlignment: 텍스트 정렬 방식입니다.
    /// - Returns: 생성된 NSAttributedString입니다.
    func attributedText(text: String = "", font: UIFont, lineHeight: CGFloat, textAlignment: NSTextAlignment = .left, additionalAttributes: [NSAttributedString.Key: Any] = [:]) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        let lineHeightValue = font.pointSize * lineHeight
        paragraphStyle.minimumLineHeight = lineHeightValue
        paragraphStyle.maximumLineHeight = lineHeightValue
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = textAlignment
            
        var attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle, // 문단 스타일 설정
        ]
        
        for (key, value) in additionalAttributes {
            attributes[key] = value
        }
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
}
