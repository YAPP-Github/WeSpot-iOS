//
//  WSLabel.swift
//  DesignSystem
//
//  Created by eunseou on 6/28/24.
//

import UIKit

public class WSLabel: UILabel {
    
    public var wsFont: WSFont
    public override var text: String? {
        didSet { font(wsFont)  }
    }
    
    /// 텍스트와 WSFont를 받아 초기화
    /// - Parameters:
    ///   - text: 설정할 텍스트입니다. 기본값은 nil입니다.
    ///   - wsFont: 사용할 WSFont입니다. ex) Header01, Body01
    ///   - textAlignment: 텍스트 정렬 방식입니다. default는 .left
    public init(wsFont: WSFont, text: String? = nil, textAlignment: NSTextAlignment = .left) {
        self.wsFont = wsFont
        
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.text = text
        self.font = wsFont.font()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// WSFont를 적용
    /// - Parameters:
    ///   - wsFont: 적용할 WSFont입니다.  ex) Header01, Body01
    func font(_ wsFont: WSFont) {
        self.font = wsFont.font()
        self.numberOfLines = 0
        self.attributedText = NSAttributedString().attributedText(
                    text: self.text ?? "",
                    font: wsFont.font(),
                    lineHeight: wsFont.lineHeight,
                    textAlignment: self.textAlignment
                )
    }
    
}
