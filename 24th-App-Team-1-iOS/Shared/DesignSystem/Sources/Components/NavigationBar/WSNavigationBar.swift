//
//  WSNavigationBar.swift
//  DesignSystem
//
//  Created by Kim dohyun on 6/30/24.
//

import UIKit

import Extensions
import SnapKit

public final class WSNavigationBar: UIView {
    
    //MARK: Properties
    public var navigationTitleLabel: WSLabel = WSLabel(wsFont: .Header02)
    public let leftBarButton: UIButton = UIButton(type: .custom)
    public let rightBarButton: UIButton = UIButton(type: .custom)
    public var navigationProperty: WSNavigationType?
    
    
    //MARK: Initializer
    public init() {
        super.init(frame: .zero)
        setupUI()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure
    private func setupUI() {
        addSubviews(leftBarButton, navigationTitleLabel, rightBarButton)
    }
    
    private func setupAttributes() {
        backgroundColor = DesignSystemAsset.Colors.gray900.color
    }

    /// WSNavigationBarLayout을 설정하는 메서드 입니다.
    /// - Parameters:
    ///  - property: WSNavigationType을 통해 해당 leftBarButtonItem, rightBarButtonItem, navigationTitleLabel을 설정 해주도록 합니다.
    ///  - Returns: WSNavigationBar Type을 반환합니다.
    @discardableResult
    public func setNavigationBarUI(property: WSNavigationType) -> Self {
        navigationProperty = property
        leftBarButton.setImage(property.items.leftItem, for: .normal)
        
        rightBarButton.setTitle(property.items.rightTextItem, for: .normal)
        rightBarButton.setImage(property.items.rightImageItem, for: .normal)
        rightBarButton.setTitleColor(property.items.rightTextItemColor, for: .normal)
        rightBarButton.titleLabel?.font = WSFont.Body04.font()
        
        navigationTitleLabel.text = property.items.centerItem
        navigationTitleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        return self
    }
    
    /// WSNavigationBar AutoLayoutt을 설정하는 메서드 입니다.
    /// - Parameters:
    ///  - property: WSNavigationPropertyType을 통해 해당 leftBarButtonItem, rightBarButtonItem의 Spacing, Scale 값을 설정하도록 합니다.
    ///  - Returns: WSNavigationBar Type을 반환합니다.
    public func setNavigationBarAutoLayout(property: WSNavigationPropertyType) {
        
        leftBarButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(property.constraints.leftBarButtonItemLeftSpacing)
            $0.top.equalToSuperview().offset(property.constraints.leftBarButtonItemTopSpacing)
            $0.width.equalTo(property.constraints.leftWidthScale)
            $0.height.equalTo(property.constraints.leftHeightScale)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        rightBarButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-property.constraints.rightBarButtonItemRightSpacing)
            $0.top.equalToSuperview().offset(property.constraints.rightBarButtonItemTopSpacing)
            $0.width.equalTo(property.constraints.rightWidthScale)
            $0.height.equalTo(property.constraints.rightHeightScale)
        }
    }
    
}
