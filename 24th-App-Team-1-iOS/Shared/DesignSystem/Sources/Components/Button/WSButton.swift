//
//  WSButton.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/5/24.
//

import UIKit

public final class WSButton: UIButton {
    
    //MARK: - Properties
    public let wsButtonType: WSButtonType
    
    public override var isHighlighted: Bool {
        didSet {
            setupHighlighted(isHighlighted)
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            setupEnabled(isEnabled)
        }
    }
    
    //MARK: - Initializer
    public init(wsButtonType: WSButtonType) {
        self.wsButtonType = wsButtonType
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Functions
    @discardableResult
    public func setupButton(text: String) -> Self {
        
        setTitle(text, for: .normal)
        backgroundColor = wsButtonType.buttonProperties.backgroundColor.color
        layer.cornerRadius = wsButtonType.buttonProperties.radius
    
        layer.borderColor = wsButtonType.buttonProperties.borderColor
        layer.borderWidth = wsButtonType.buttonProperties.borderWidth ?? 0.0
        setTitleColor(wsButtonType.buttonProperties.textColor, for: .normal)
        titleLabel?.font = wsButtonType.buttonProperties.textFont
        
        return self
    }
    

    private func setupEnabled(_ isEnabled: Bool) {
        let enabledBackgroundColor = isEnabled ? wsButtonType.buttonProperties.backgroundColor.color : wsButtonType.disabledBackgroundColor
        let enabledTextColor = isEnabled ? wsButtonType.buttonProperties.textColor : wsButtonType.disabledTextColor
        backgroundColor = enabledBackgroundColor
        setTitleColor(enabledTextColor, for: .normal)
        layer.borderColor = isEnabled ? wsButtonType.pressedBorderColor : UIColor.clear.cgColor
    }

    public func setupFont(font: WSFont) {
        titleLabel?.font = font.font()
    }
    
    private func setupHighlighted(_ isHighlighted: Bool) {
        backgroundColor = isHighlighted ? wsButtonType.pressedBackgroundColor : wsButtonType.buttonProperties.backgroundColor.color
        setTitleColor(wsButtonType.pressedTextColor, for: .highlighted)
        layer.borderColor = wsButtonType.pressedBorderColor
    }
        
}
