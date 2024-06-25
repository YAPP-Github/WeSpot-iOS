//
//  UILabel+Extension.swift
//  DesignSystem
//
//  Created by eunseou on 6/25/24.
//

import UIKit

extension UILabel {
    
    func WSLabel(_ wsFont: WSFont) {
        let font = wsFont.font()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = wsFont.lineHeight

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .kern: wsFont.letterSpacing
        ]
        
        if let currentText = self.text {
            self.attributedText = NSAttributedString(string: currentText, attributes: attributes)
        } else {
            self.attributedText = NSAttributedString(string: "", attributes: attributes)
        }
    }
}

/*
 사용 예시
let label = UILabel()
label.text = "Hello, World!"
label.WSLabel(.Header01)
*/
