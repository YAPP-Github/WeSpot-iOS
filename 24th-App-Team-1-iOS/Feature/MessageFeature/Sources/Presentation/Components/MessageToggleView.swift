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
            updateToggleLayout(isSelected)
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
        
        addSubviews(homeButton, storageButton, underLine, selectedLine)
    }
    
    private func setupAttributes() {
        
        homeButton.do {
            $0.backgroundColor = UIColor.clear
            $0.titleLabel?.font = WSFont.Body03.font()
            $0.setTitle("쪽지 홈", for: .normal)
            $0.setTitleColor(DesignSystemAsset.Colors.gray100.color, for: .normal)
        }
        
        storageButton.do {
            $0.backgroundColor = UIColor.clear
            $0.titleLabel?.font = WSFont.Body03.font()
            $0.setTitle("내 쪽지함", for: .normal)
            $0.setTitleColor(DesignSystemAsset.Colors.gray400.color, for: .normal)
        }
        
        underLine.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
        }
        
        selectedLine.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray100.color
        }
    }
    
    private func setupAutoLayout() {
        
        homeButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.width.equalTo(self).multipliedBy(0.5).offset(-20)
        }
        
        storageButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.right.equalToSuperview().inset(20)
            $0.width.equalTo(self).multipliedBy(0.5).offset(-20)
        }
        
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-1)
        }
        
        selectedLine.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(2)
            $0.width.equalTo(self).multipliedBy(0.5).offset(-20)
            $0.bottom.equalToSuperview().offset(-2)
        }
    }
    
    private func updateToggleLayout(_ isSelected: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self else { return }
            self.selectedLine.frame.origin.x = isSelected ? 20 : (self.frame.size.width - self.selectedLine.frame.size.width) - 20
            self.homeButton.setTitleColor(isSelected ? DesignSystemAsset.Colors.gray100.color :  DesignSystemAsset.Colors.gray400.color, for: .normal)
            self.storageButton.setTitleColor(isSelected ? DesignSystemAsset.Colors.gray400.color :  DesignSystemAsset.Colors.gray100.color, for: .normal)
        }
    }
}
