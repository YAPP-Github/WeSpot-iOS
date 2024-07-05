//
//  WSButton.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/5/24.
//

import UIKit

public enum WSButtonColor {
    case primary
    case secondary
    case tertiary
    
    var color: UIColor {
        switch self {
        case .primary:
            return DesignSystemAsset.Colors.primary300.color
        case .secondary:
            return DesignSystemAsset.Colors.gray500.color
        case .tertiary:
            return DesignSystemAsset.Colors.gray700.color
        }
    }
}


public struct WSButtonProperty {
    let backgroundColor: WSButtonColor
    let textColor: UIColor?
    let textFont: UIFont?
    let radius: CGFloat
    let borderColor: CGColor?
    let borderWidth: CGFloat?
}

public enum WSButtonType {
    case `default`
    case supplementaryButton(WSButtonColor)
    case strokeButton
    case disableButton
    
    
    var buttonProperties: WSButtonProperty {
        switch self {
        case .default:
            
            //TODO: BorderColor, BorderWidth 나중에 없애기
            return .init(
                backgroundColor: .primary,
                textColor: DesignSystemAsset.Colors.gray900.color,
                textFont: WSFont.Body03.font(),
                radius: 12,
                borderColor: nil,
                borderWidth: 0
            )
        case let .supplementaryButton(colorType):
            return .init(
                backgroundColor: colorType,
                textColor: colorType == .primary ? DesignSystemAsset.Colors.gray900.color : DesignSystemAsset.Colors.gray100.color,
                textFont: WSFont.Body03.font(),
                radius: 10,
                borderColor: nil,
                borderWidth: 0
            )
        case .strokeButton:
            return .init(
                backgroundColor: .tertiary,
                textColor: DesignSystemAsset.Colors.gray100.color,
                textFont: WSFont.Body03.font(),
                radius: 12,
                borderColor: DesignSystemAsset.Colors.primary400.color.cgColor,
                borderWidth: 1
            )
        case .disableButton:
            return .init(
                backgroundColor: .secondary,
                textColor: DesignSystemAsset.Colors.gray300.color.withAlphaComponent(0.8),
                textFont: WSFont.Body03.font(),
                radius: 12,
                borderColor: nil,
                borderWidth: 0
            )
        }
        
    }
}


public final class WSButton: UIButton {
    
    public let wsButtonType: WSButtonType
    
    public override var isHighlighted: Bool {
        didSet {
            setupHighlighted(isHighlighted)
        }
    }
    
    
    
    public init(wsButtonType: WSButtonType) {
        self.wsButtonType = wsButtonType
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
    
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
    
    private func setupHighlighted(_ isHighlighted: Bool) {
        backgroundColor = isHighlighted ? DesignSystemAsset.Colors.primary500.color : wsButtonType.buttonProperties.backgroundColor.color
    }
    
    
}
