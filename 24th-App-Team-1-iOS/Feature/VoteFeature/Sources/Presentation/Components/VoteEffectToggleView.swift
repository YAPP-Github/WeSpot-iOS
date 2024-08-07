//
//  VoteEffectToggleView.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/7/24.
//

import DesignSystem
import UIKit


final class VoteEffectToggleView: UIView {
    let latestButton: UIButton = UIButton(type: .custom)
    let previousButton: UIButton = UIButton(type: .custom)
    
    var isSelected: VoteEffectType = .latest {
        didSet {
            print("update isSelected : \(isSelected)")
            updateToggleLayout(isSelected: isSelected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(latestButton, previousButton)
    }
    
    private func setupAttributes() {
        latestButton.do {
            $0.configuration = .filled()
            $0.configuration?.baseForegroundColor = DesignSystemAsset.Colors.gray100.color
            $0.configuration?.baseBackgroundColor = DesignSystemAsset.Colors.gray500.color
            $0.configuration?.attributedTitle = AttributedString(NSAttributedString(string: VoteStrings.voteRealTimeButtonText, attributes: [
                .font: WSFont.Body05.font(),
            ]))
            $0.layer.cornerRadius = 15
            $0.layer.borderWidth = 0
            $0.layer.borderColor = DesignSystemAsset.Colors.gray400.color.cgColor
            $0.clipsToBounds = true
        }
        
        previousButton.do {
            $0.configuration = .filled()
            $0.configuration?.baseForegroundColor = DesignSystemAsset.Colors.gray400.color
            $0.configuration?.baseBackgroundColor = .clear
            $0.configuration?.attributedTitle = AttributedString(NSAttributedString(string: VoteStrings.voteLastTimeButtonText, attributes: [
                .font: WSFont.Body05.font(),
            ]))
            $0.layer.borderColor = DesignSystemAsset.Colors.gray400.color.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
    }
    
    private func setupAutoLayout() {
        previousButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.width.equalTo(76)
            $0.height.equalTo(31)
            $0.left.equalToSuperview().inset(20)
        }
        
        latestButton.snp.makeConstraints {
            $0.top.equalTo(previousButton)
            $0.width.equalTo(88)
            $0.height.equalTo(31)
            $0.left.equalTo(previousButton.snp.right).offset(12)
        }
    }
    
    private func updateToggleLayout(isSelected: VoteEffectType) {
        latestButton.configuration?.baseBackgroundColor = isSelected == .latest ? DesignSystemAsset.Colors.gray500.color : .clear
        latestButton.configuration?.baseForegroundColor = isSelected == .latest ? DesignSystemAsset.Colors.gray100.color : DesignSystemAsset.Colors.gray400.color
        latestButton.layer.borderWidth = isSelected  == .latest ? 0 : 1
        
        previousButton.configuration?.baseBackgroundColor = isSelected == .previous ? DesignSystemAsset.Colors.gray500.color : .clear
        previousButton.configuration?.baseForegroundColor = isSelected == .previous ? DesignSystemAsset.Colors.gray100.color : DesignSystemAsset.Colors.gray400.color
        previousButton.layer.borderWidth = isSelected == .previous ? 0 : 1
        
    }
}
