//
//  WSNavigationBar.swift
//  DesignSystem
//
//  Created by Kim dohyun on 6/30/24.
//

import UIKit

import Extensions
import SnapKit

public struct WSNavigationProperty: Equatable {
    var leftItem: UIImage?
    var centerItem: String?
    var rightImageItem: UIImage?
    var rightTextItem: String?
    
    
    mutating func setupRightItem(rightImageItem: UIImage) {
        self.rightImageItem = rightImageItem
    }
    
    mutating func setupLeftItem(leftImage: UIImage) {
        self.leftItem = leftImage
    }
    
    mutating func setupCenterItem(text: String) {
        self.centerItem = text
    }
}


public enum WSNavigationType: Equatable {
    case `default`
    case center(String)
    case leftIcon(UIImage)
    case leftWithCenterItem(UIImage, String)
    case rightIcon(UIImage?, String?)
    case leftWithRightItem(UIImage, UIImage?, String?)
    
    var items: WSNavigationProperty {
        switch self {
        case .default:
            return .init(
                leftItem: DesignSystemAsset.Images.logo.image,
                rightImageItem: DesignSystemAsset.Images.notice.image
            )
        case let .center(centerItem):
            return .init(centerItem: centerItem)
        case let .leftIcon(leftItem):
            return .init(leftItem: leftItem)
        case let .leftWithCenterItem(leftItem, centerItem):
            return .init(
                leftItem: leftItem,
                centerItem: centerItem
            )
        case let .rightIcon(rightImageItem, rightTextItem):
            return .init(
                rightImageItem: rightImageItem,
                rightTextItem: rightTextItem
            )
        case let .leftWithRightItem(leftItem, rightImageItem, rightTextItem):
            return .init(
                leftItem: leftItem,
                rightImageItem: rightImageItem,
                rightTextItem: rightTextItem
            )
        }
    }
}

public final class WSNavigationBar: UINavigationBar {
    
    private let navigationTitleLabel: WSLabel = WSLabel(wsFont: .Header02)
    private let leftBarButton: UIButton = UIButton(type: .custom)
    private let rightBarButton: UIButton = UIButton(type: .custom)
    
    
    
    public init() {
        super.init(frame: .zero)
        setupUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubViews(leftBarButton, navigationTitleLabel, rightBarButton)
    }
    
    private func setupAutoLayout() {
        leftBarButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(43)
            $0.centerY.equalToSuperview()
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        rightBarButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-18)
            $0.centerY.equalToSuperview()
        }
    }

    
    public func setPropertyNavigationBar(property: WSNavigationType) {
        leftBarButton.setImage(property.items.leftItem, for: .normal)
        
        rightBarButton.setTitle(property.items.rightTextItem, for: .normal)
        rightBarButton.setImage(property.items.rightImageItem, for: .normal)
        
        navigationTitleLabel.text = property.items.centerItem
        navigationTitleLabel.textColor = DesignSystemAsset.Colors.gray300.color
    }
    
}
