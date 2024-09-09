//
//  SignUpProfileCharacterCollectionViewCell.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/29/24.
//

import DesignSystem
import UIKit

import SnapKit
import ReactorKit
import Kingfisher


final class SignUpProfileCharacterCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    private let characterContainerView: UIView = UIView()
    private let characterImageView: UIImageView = UIImageView()
    private let selectedImageView: UIImageView = UIImageView()
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        characterContainerView.addSubview(characterImageView)
        contentView.addSubviews(characterContainerView, selectedImageView)
    }
    
    private func setupAutoLayout() {
        characterContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        selectedImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.right.equalTo(characterContainerView)
        }
    }
    
    private func setupAttributes() {
        characterImageView.do {
            $0.image = DesignSystemAsset.Images.girl.image
        }
        
        selectedImageView.do {
            $0.image = DesignSystemAsset.Images.icProfileCheck.image
            $0.isHidden = true
        }
        
        characterContainerView.do {
            $0.layer.cornerRadius = 60 / 2
            $0.layer.borderWidth = 0
            $0.layer.borderColor = DesignSystemAsset.Colors.gray100.color.cgColor
            $0.backgroundColor = DesignSystemAsset.Colors.gray500.color
        }
    }
    
}


extension SignUpProfileCharacterCollectionViewCell: ReactorKit.View {
    
    func bind(reactor: SignUpProfileCharacterCellReactor) {
        
        reactor.state
            .map { $0.iconURL}
            .bind(with: self) { owner, url in
                owner.characterImageView.kf.setImage(with: url)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.item == $0.selectedItem }
            .bind(with: self) { owner, _ in
                owner.selectedImageView.isHidden = false
                owner.characterContainerView.layer.borderWidth = 2
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.item != $0.selectedItem }
            .bind(with: self) { owner, _ in
                owner.selectedImageView.isHidden = true
                owner.characterContainerView.layer.borderWidth = 0
            }
            .disposed(by: disposeBag)
    }
}
