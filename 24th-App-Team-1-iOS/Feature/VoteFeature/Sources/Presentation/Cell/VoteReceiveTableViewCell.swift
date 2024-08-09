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
    
    private let receiveNewImageView: UIImageView = UIImageView()
    private let receiveContainerView: UIView = UIView()
    private let receiveAccessoryView: UIImageView = UIImageView()
    private let receiveTitleLabel: WSLabel = WSLabel(wsFont: .Body04)
    private let receiveDescprtionLabel: WSLabel = WSLabel(wsFont: .Body07)
    private let receiveImageView: UIImageView = UIImageView()
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupAutoLayout()
        setupAttributeds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 16, right: 0))
    }
    
    private func setupUI() {
        receiveContainerView.addSubviews(receiveTitleLabel, receiveDescprtionLabel, receiveImageView, receiveAccessoryView, receiveNewImageView)
        contentView.addSubviews(receiveContainerView)
    }
    
    private func setupAutoLayout() {
        receiveContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        receiveNewImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(12)
            $0.size.equalTo(6)
        }
        
        receiveAccessoryView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(10)
            $0.size.equalTo(40)
            $0.centerY.equalToSuperview()
        }
        
        receiveImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.size.equalTo(40)
        }
        
        receiveTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.left.equalTo(receiveImageView.snp.right).offset(12)
            $0.height.equalTo(24)
            $0.right.equalTo(receiveAccessoryView.snp.left)
        }
        
        receiveDescprtionLabel.snp.makeConstraints {
            $0.top.equalTo(receiveTitleLabel.snp.bottom)
            $0.left.equalTo(receiveTitleLabel)
            $0.right.equalTo(receiveAccessoryView.snp.left)
            $0.height.equalTo(20)
        }
    }
    
    private func setupAttributeds() {
        
        self.do {
            $0.backgroundColor = .clear
        }
        
        receiveContainerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
        }
        
        receiveAccessoryView.do {
            $0.image = DesignSystemAsset.Images.arrowRight.image
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
        
        receiveNewImageView.do {
            $0.image = DesignSystemAsset.Images.icInventoryNewFiled.image
        }
    }
}


extension VoteReceiveTableViewCell: ReactorKit.View {
    func bind(reactor: VoteReceiveCellReactor) {
        reactor.state
            .map { $0.title }
            .distinctUntilChanged()
            .bind(to: receiveTitleLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state
            .map { "우리 반 친구 \($0.voteCount)명이 나에게 투표했어요" }
            .distinctUntilChanged()
            .bind(to: receiveDescprtionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { !$0.isNew }
            .distinctUntilChanged()
            .bind(to: receiveNewImageView.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
