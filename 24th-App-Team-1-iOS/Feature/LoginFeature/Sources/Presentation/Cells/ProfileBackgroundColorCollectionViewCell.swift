//
//  ProfileBackgroundColorCollectionViewCell.swift
//  LoginFeature
//
//  Created by eunseou on 8/6/24.
//

import UIKit
import DesignSystem

import SnapKit

public final class ProfileBackgroundColorCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Identifier
    public static let identifier = "ProfileBackgroundColorCollectionViewCell"
    
    //MARK: - Properties
    private let colorView = UIView()
    private let checkImageView = UIImageView()
    
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
        
        contentView.addSubviews(colorView, checkImageView)
    }
    
    private func setupAutoLayout() {
        
        colorView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
            $0.size.equalTo(60)
        }
        
        checkImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.trailing.equalTo(colorView)
        }
    }
    
    private func setupAttributes() {
        
        colorView.do {
            $0.layer.cornerRadius = 30
        }
        
        checkImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = DesignSystemAsset.Images.icProfileCheck.image
            $0.isHidden = true
        }
    }
    
    public func configureCell(background: String) {
        colorView.backgroundColor = UIColor(hex: background)
    }
    
    public func selectedCell() {
        colorView.do {
            $0.layer.cornerRadius = 30
            $0.layer.borderWidth = 2
            $0.layer.borderColor = DesignSystemAsset.Colors.gray100.color.cgColor
        }
        checkImageView.isHidden = false
    }
    
    public func deselectCell() {
        colorView.do {
            $0.layer.borderWidth = 0
        }
        checkImageView.isHidden = true
    }
}
