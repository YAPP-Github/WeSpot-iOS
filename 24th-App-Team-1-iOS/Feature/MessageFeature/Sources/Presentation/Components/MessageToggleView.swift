//
//  MessageToggleView.swift
//  MessageFeature
//
//  Created by eunseou on 7/21/24.
//

import UIKit
import Util
import DesignSystem

import SnapKit
import Then

final class MessageToggleView: UIView {
    
    // MARK: - Properties
    let homeButton = UIButton()
    let storageButton = UIButton()
    private let underLine = UIView()
    private let selectedLine = UIView()
    var isSelected: Bool = true {
        didSet {
            
        }
    }
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
        
        addSubviews(homeButton, underLine)
    }
    
    private func setupAttributes() {
        
        homeButton.do {
            $0.backgroundColor = UIColor.clear
            $0.titleLabel?.font = WSFont.Body03.font()
            $0.setTitle("쪽지 홈", for: .normal)
            $0.setTitleColor(DesignSystemAsset.Colors.gray100.color, for: .normal)
        }
        
        underLine.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
        }
    }
    
    private func setupAutoLayout() {
        
        homeButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-1)
        }
    }
}
