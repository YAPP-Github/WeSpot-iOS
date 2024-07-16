//
//  VoteResultCollectionViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/14/24.
//

import DesignSystem
import UIKit

final class VoteResultCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let rankView: VoteRankView = VoteRankView()
    private let descrptionLabel: WSLabel = WSLabel(wsFont: .Body03)
    private let faceImageView: UIImageView = UIImageView()
    private let nameLabel: WSLabel = WSLabel(wsFont: .Header01)
    private let introduceLabel: WSLabel = WSLabel(wsFont: .Body07)
    private let resultButton: WSButton = WSButton(wsButtonType: .secondaryButton)
    
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
        addSubviews(rankView, descrptionLabel, faceImageView, nameLabel, introduceLabel, resultButton)
    }
    
    //MARK: - Configure
    private func setupAutoLayout() {
        rankView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.left.equalToSuperview().offset(20)
            $0.width.equalTo(98)
            $0.height.equalTo(36)
        }
        
        descrptionLabel.snp.makeConstraints {
            $0.top.equalTo(rankView.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(48)
            $0.width.equalTo(207)
        }
        
        faceImageView.snp.makeConstraints {
            $0.top.equalTo(descrptionLabel.snp.bottom).offset(11)
            $0.width.height.equalTo(120)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(faceImageView.snp.bottom).offset(11)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        resultButton.snp.makeConstraints {
            $0.top.equalTo(introduceLabel.snp.bottom).offset(24)
            $0.height.equalTo(33)
            $0.width.equalTo(104)
            $0.centerX.equalToSuperview()
        }        
    }
    
    private func setupAttributes() {
        
        //TODO: 테스트 코드
        
        backgroundColor = DesignSystemAsset.Colors.white.color.withAlphaComponent(0.15)
        layer.cornerRadius = 20
        clipsToBounds = true

        resultButton.do {
            $0.setupButton(text: "전체 결과 보기")
            $0.setupFont(font: .Body06)
        }
        
        introduceLabel.do {
            $0.text = "안녕! 모르는거 있으면 나한테 다 물어봐"
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        nameLabel.do {
            $0.text = "이지호"
            $0.textColor = DesignSystemAsset.Colors.primary300.color
        }
        
        rankView.do {
            $0.rankLabel.text = "10표"
            $0.rankImageView.image = DesignSystemAsset.Images.voteCrwon.image
            $0.layer.cornerRadius = 18
            $0.layer.masksToBounds = true
            $0.clipsToBounds = true
            $0.layer.borderColor = DesignSystemAsset.Colors.gray300.color.cgColor
            $0.layer.borderWidth = 1
        }
        
        faceImageView.do {
            $0.image = DesignSystemAsset.Images.voteCharacter.image
        }
        
        descrptionLabel.do {
            $0.text = "우리 반에서 모르는게생기면물어보고싶은은은은은은은은 친구는?"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
    }
}
