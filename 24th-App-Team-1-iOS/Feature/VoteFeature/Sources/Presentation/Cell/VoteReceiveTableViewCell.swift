//
//  VoteReceiveTableViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/8/24.
//

import DesignSystem
import UIKit

import ReactorKit

final class VoteReceiveTableViewCell: UITableViewCell {
    
    
    private let receiveTitleLabel: WSLabel = WSLabel(wsFont: .Body04)
    private let receiveDescprtionLabel: WSLabel = WSLabel(wsFont: .Body07)
    private let receiveImageView: UIImageView = UIImageView()
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(receiveTitleLabel, receiveDescprtionLabel, receiveImageView)
    }
    
    private func setupAutoLayout() {
        receiveImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.size.equalTo(40)
        }
        
        receiveTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.left.equalTo(receiveImageView.snp.right).offset(12)
            $0.height.equalTo(24)
        }
        
        receiveDescprtionLabel.snp.makeConstraints {
            $0.top.equalTo(receiveTitleLabel.snp.bottom)
            $0.left.equalTo(receiveTitleLabel)
            $0.height.equalTo(20)
        }
    }
    
    private func setupAttributeds() {
        self.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
            $0.accessoryType = .disclosureIndicator
        }
        
        receiveImageView.do {
            $0.image = DesignSystemAsset.Images.icInventoryVoteFiled.image
            $0.contentMode = .scaleAspectFill
        }
        
        receiveTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "스포츠를 좋아하는 친구"
        }
        
        receiveDescprtionLabel.do {
            $0.text = "우리 반 친구 10명이 나에게 투표했어요"
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
    }
}


extension VoteReceiveTableViewCell: ReactorKit.View {
    func bind(reactor: VoteReceiveCellReactor) {
        //TODO: Binding 코드 추가
    }
}
