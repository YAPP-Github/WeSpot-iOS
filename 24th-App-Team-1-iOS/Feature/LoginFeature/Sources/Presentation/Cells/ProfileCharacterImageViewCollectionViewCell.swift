//
//  ProfileCharacterImageViewCollectionViewCell.swift
//  LoginFeature
//
//  Created by eunseou on 8/6/24.
//

import UIKit
import DesignSystem

import SnapKit

public final class ProfileCharacterImageViewCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "ProfileCharacterImageViewCollectionViewCell"
    
    //MARK: - Properties
    private let selectedBorderView = UIView()
    private let checkImageView = UIImageView()
    private let characterView = UIImageView()
    
    //MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupUI() {
        
        contentView.addSubviews(selectedBorderView, checkImageView)
        selectedBorderView.addSubview(characterView)
    }
    
    private func setupAutoLayout() {
        
        selectedBorderView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
            $0.size.equalTo(60)
        }
        
        checkImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.trailing.equalTo(selectedBorderView)
        }
        
        characterView.snp.makeConstraints {
            $0.center.equalTo(selectedBorderView)
            $0.size.equalTo(selectedBorderView).multipliedBy(0.7)
        }
    }
    
    private func setupAttributes() {
        
        backgroundColor = .clear
        
        checkImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = DesignSystemAsset.Images.icProfileCheck.image
            $0.isHidden = true
        }
        
        characterView.do {
            $0.image = DesignSystemAsset.Images.icCommonProfile427323024.image
            $0.contentMode = .scaleAspectFit
        }
    }
    
    public func configureCell(image: URL) {
        //TODO: 실제 이미지 URL을 받아올 떄 적용
    }
    
    public func selectedCell() {
        selectedBorderView.do {
            $0.layer.cornerRadius = 30
            $0.layer.borderWidth = 2
            $0.layer.borderColor = DesignSystemAsset.Colors.gray100.color.cgColor
            $0.backgroundColor = DesignSystemAsset.Colors.gray500.color
        }
        checkImageView.isHidden = false
    }
    
    public func deselectCell() {
        selectedBorderView.do {
            $0.layer.borderWidth = 0
            $0.backgroundColor = .clear
        }
        checkImageView.isHidden = true
    }
    
}
