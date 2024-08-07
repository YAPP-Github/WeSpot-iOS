//
//  ToggleProfileTableViewButton.swift
//  LoginFeature
//
//  Created by eunseou on 8/6/24.
//

import UIKit
import DesignSystem
import SnapKit

public final class ToggleProfileTableViewButton: UIButton {
    
    public enum ProfileButtonType {
        case character
        case background
    }
    
    //MARK: - Properties
    public var profileButtonType: ProfileButtonType
    private var isSelectedState: Bool = false {
        didSet {
            updateStyle()
        }
    }
    
    //MARK: - Initializer
    public init(profileButtonType: ProfileButtonType) {
        self.profileButtonType = profileButtonType
        super.init(frame: .zero)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Function
    private func setupButton() {
        titleLabel?.font = WSFont.Body03.font()
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.textAlignment = .center
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        configuration.imagePadding = 8
        
        self.configuration = configuration
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    private func updateStyle() {
        configureStyle(title: titleForType(), image: imageForType(), backgroundColor: backgroundColorForState(), titleColor: titleColorForState(), borderWidth: borderWidthForState(), borderColor: borderColorForState())
    }
    
    private func configureStyle(title: String, image: UIImage?, backgroundColor: UIColor, titleColor: UIColor, borderWidth: CGFloat, borderColor: UIColor) {
        var config = self.configuration
        config?.title = title
        config?.image = image
        config?.background.backgroundColor = backgroundColor
        config?.baseForegroundColor = titleColor
        self.configuration = config
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    private func titleForType() -> String {
        switch profileButtonType {
        case .character:
            return "캐릭터 고르기"
        case .background:
            return "배경색 고르기"
        }
    }
    
    private func imageForType() -> UIImage? {
        switch profileButtonType {
        case .character:
            return isSelectedState ? DesignSystemAsset.Images.icProfileCharacterSelected.image : DesignSystemAsset.Images.icProfileCharacterUnselected.image
        case .background:
            return isSelectedState ? DesignSystemAsset.Images.icProfileBackgroundSelected.image : DesignSystemAsset.Images.icProfileBackgroundUnselected.image
        }
    }
    
    private func backgroundColorForState() -> UIColor {
        return isSelectedState ? DesignSystemAsset.Colors.gray500.color : DesignSystemAsset.Colors.gray900.color
    }
    
    private func titleColorForState() -> UIColor {
        return isSelectedState ? DesignSystemAsset.Colors.gray100.color : DesignSystemAsset.Colors.gray400.color
    }
    
    private func borderWidthForState() -> CGFloat {
        return isSelectedState ? 0 : 1
    }
    
    private func borderColorForState() -> UIColor {
        return isSelectedState ? .clear : (profileButtonType == .character ? UIColor.gray : UIColor.darkGray)
    }
    
    public func setSelectedState(_ isSelected: Bool) {
        isSelectedState = isSelected
    }
}
