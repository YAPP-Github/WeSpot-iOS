//
//  WSTabBar.swift
//  DesignSystem
//
//  Created by eunseou on 7/16/24.
//

import UIKit

import Extensions
import SnapKit
import Then

final public class WSTabBar: UIView {

    // MARK: - Properties
    private let topBorder = UIView()
    private let stackView = UIStackView()
    public let voteButton = WSTabBarButton(type: .vote)
    public let messageButton = WSTabBarButton(type: .message)
    public let allButton = WSTabBarButton(type: .all)
    
    // MARK: - Initializer
    public init() {
        super.init(frame: .zero)
        
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
        
        addSubviews(stackView, topBorder)
        stackView.addArrangedSubviews(voteButton, messageButton, allButton)
    }
    
    private func setupAttributes() {
        
        backgroundColor = DesignSystemAsset.Colors.gray800.color
        
        topBorder.backgroundColor = DesignSystemAsset.Colors.gray700.color
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 30
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
    }
    
    private func setupAutoLayout() {
        
        topBorder.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().inset(14)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.greaterThanOrEqualToSuperview().inset(37.5)
        }
    }
}
