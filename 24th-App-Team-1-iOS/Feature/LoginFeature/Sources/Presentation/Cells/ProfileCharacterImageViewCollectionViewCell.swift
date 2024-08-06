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
        
        contentView.addSubviews(characterView)
    }
    
    private func setupAutoLayout() {
        
        characterView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
            $0.size.equalTo(60)
        }
    }
    
    private func setupAttributes() {
        
        backgroundColor = .clear
        
        characterView.image = DesignSystemAsset.Images.icCommonProfile427323024.image
    }
    
    public func configureCell(image: String) {
        //TODO: 실제 이미지 URL을 받아올 떄 적용 
    }
    
}
