//
//  WSTabBarButton.swift
//  DesignSystem
//
//  Created by eunseou on 7/17/24.
//

import UIKit

import SnapKit
import Then

public final class WSTabBarButton: UIButton {

    public enum tabBarType {
        case vote
        case message
        case all
        
        var text: String {
            switch self {
            case .vote:
                "투표"
            case .message:
                "쪽지"
            case .all:
                "전체"
            }
        }
        
        var selectedImage: UIImage {
            switch self {
            case .vote:
                DesignSystemAsset.Images.icTabbarVoteSelected.image
            case .message:
                DesignSystemAsset.Images.icTabbarMessageSelected.image
            case .all:
                DesignSystemAsset.Images.icTabbarAllSelected.image
            }
        }
        
        var unSelectedImage: UIImage {
            switch self {
            case .vote:
                DesignSystemAsset.Images.icTabbarVoteUnseleceted.image
            case .message:
                DesignSystemAsset.Images.icTabbarMessageUnselected.image
            case .all:
                DesignSystemAsset.Images.icTabbarAllUnselected.image
            }
        }
    }
    
    // MARK: - Properties
    private let tabImageView = UIImageView()
    private let tabLabel = WSLabel(wsFont: .Body09)
    private let type: tabBarType
    
    // MARK: - Initializer
    public init(type: tabBarType) {
        self.type = type
        super.init(frame: .zero)
        
        setupUI()
        setupAttributes(image: type.unSelectedImage, text: type.text)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
        
        addSubviews(tabImageView, tabLabel)
    }
    
    private func setupAttributes(image: UIImage, text: String) {
        
        backgroundColor = DesignSystemAsset.Colors.gray800.color
        
        tabImageView.image = image
        
        tabLabel.text = text
    }
    
    private func setupAutoLayout() {
        
        tabImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
        tabLabel.snp.makeConstraints {
            $0.top.equalTo(tabImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    
    public func updateState(isSelected: Bool) {
        let image = isSelected ? type.selectedImage : type.unSelectedImage
        tabImageView.image = image
        tabLabel.textColor = isSelected ? DesignSystemAsset.Colors.gray100.color : DesignSystemAsset.Colors.gray400.color
    }
}
