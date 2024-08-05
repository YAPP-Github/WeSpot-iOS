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
        
        addSubviews(colorView)
    }
    
    private func setupAutoLayout() {
        
        colorView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(60)
        }
    }
    
    private func setupAttributes() {
        
        backgroundColor = .clear
        
        colorView.backgroundColor = DesignSystemAsset.Colors.gray200.color
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = colorView.bounds.height / 2
    }
    
}
