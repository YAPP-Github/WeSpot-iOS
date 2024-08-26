//
//  ProfileBlockTableViewCell.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import DesignSystem
import UIKit

import Kingfisher
import ReactorKit

final class ProfileBlockTableViewCell: UITableViewCell {
    private let profileContainerView: UIView = UIView()
    private let profileImageView: UIImageView = UIImageView()
    private let notificationLabel: WSLabel = WSLabel(wsFont: .Body06)
    private let contentLabel: WSLabel = WSLabel(wsFont: .Body05)
    private let blockButton: WSButton = WSButton(wsButtonType: .secondaryButton)
    private let lineView: UIView = UIView()
    var disposeBag: DisposeBag = DisposeBag()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        profileContainerView.addSubview(profileImageView)
        contentView.addSubviews(profileContainerView, notificationLabel, contentLabel, blockButton, lineView)
    }
    
    private func setupAutoLayout() {
        profileContainerView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        notificationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.equalTo(profileContainerView.snp.right).offset(12)
            $0.height.equalTo(21)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(notificationLabel.snp.bottom)
            $0.left.equalTo(profileContainerView.snp.right).offset(12)
            $0.height.equalTo(22)
        }
        
        blockButton.snp.makeConstraints {
            $0.width.equalTo(65)
            $0.height.equalTo(28)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview().offset(-1)
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .clear
        }
        
        blockButton.do {
            $0.setupButton(text: "차단 해제")
            $0.setupFont(font: .Body09)
            $0.layer.cornerRadius = 14
        }
        
        notificationLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.textAlignment = .left
            $0.text = "From."
        }
        
        contentLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "역삼중 1학년 16반 이지호호호"
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
        
        profileContainerView.do {
            $0.layer.cornerRadius = 40 / 2
            $0.clipsToBounds = true
        }
        
        profileImageView.do {
            $0.image = DesignSystemAsset.Images.girl.image
        }
        
        lineView.do {
            $0.backgroundColor = .separator
        }
        
    }
    
}

extension ProfileBlockTableViewCell: ReactorKit.View {
    func bind(reactor: ProfileUserBlockCellReactor) {
        
        blockButton.rx.tap
            .throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedUserBlockButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.senderName }
            .distinctUntilChanged()
            .bind(to: contentLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { UIColor(hex: $0.backgoundColor) }
            .distinctUntilChanged()
            .bind(to: profileContainerView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.iconURL }
            .distinctUntilChanged()
            .bind(with: self) { owner, image in
                owner.profileImageView.kf.setImage(with: image)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isUpdate == true ? "해체 완료" : "차단 해제" }
            .distinctUntilChanged()
            .bind(to: blockButton.rx.title())
            .disposed(by: disposeBag)
        
        reactor.state
            .map { !$0.isUpdate }
            .distinctUntilChanged()
            .bind(to: blockButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
