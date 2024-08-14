//
//  ProfileBackgroundCollectionViewCell.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/13/24.
//

import DesignSystem
import UIKit

import SnapKit
import ReactorKit

final class ProfileBackgroundCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let colorView: UIView = UIView()
    private let selectedImageView: UIImageView = UIImageView()
    public var disposeBag: DisposeBag = DisposeBag()
    
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
        contentView.addSubviews(colorView, selectedImageView)
    }
    
    private func setupAutoLayout() {
        colorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        selectedImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.right.equalTo(colorView)
        }
    }
    
    private func setupAttributes() {
        
        colorView.do {
            $0.layer.cornerRadius = 60 / 2
            $0.clipsToBounds = true
            $0.layer.borderWidth = 0
            $0.layer.borderColor = DesignSystemAsset.Colors.gray100.color.cgColor
        }
        
        selectedImageView.do {
            $0.image = DesignSystemAsset.Images.icProfileCheck.image
            $0.isHidden = true
        }
    }
}

extension ProfileBackgroundCollectionViewCell: ReactorKit.View {
    
    func bind(reactor: ProfileBackgroundCellReactor) {
        
        reactor.state
            .map { UIColor(hex: $0.backgroundColor) }
            .distinctUntilChanged()
            .bind(to: colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.item == $0.selectedItem }
            .bind(with: self) { owner, _ in
                owner.selectedImageView.isHidden = false
                owner.colorView.layer.borderWidth = 2
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.item != $0.selectedItem }
            .bind(with: self) { owner, _ in
                owner.selectedImageView.isHidden = true
                owner.colorView.layer.borderWidth = 0
            }
            .disposed(by: disposeBag)
    }
}



