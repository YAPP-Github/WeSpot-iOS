//
//  ProfileAlarmTableViewCell.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import DesignSystem
import UIKit

import ReactorKit


final class ProfileAlarmTableViewCell: UITableViewCell {
    
    //MARK: Properties
    private let contentLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let descrptionLabel: WSLabel = WSLabel(wsFont: .Body08)
    private let toggleSwitch: UISwitch = UISwitch()
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
        contentView.addSubviews(contentLabel, descrptionLabel, toggleSwitch)
    }
    
    private func setupAutoLayout() {
        contentLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(24)
            $0.right.equalTo(toggleSwitch.snp.left)
        }
        
        descrptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(6)
            $0.height.equalTo(20)
            $0.right.equalTo(toggleSwitch.snp.left)
        }
        
        toggleSwitch.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        contentLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .left
        }
        
        descrptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray400.color
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
    }
    
    
}

extension ProfileAlarmTableViewCell: ReactorKit.View {
    
    
    func bind(reactor: ProfileAlarmCellReactor) {
        reactor.state
            .map { $0.content }
            .distinctUntilChanged()
            .bind(to: contentLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.descrption }
            .distinctUntilChanged()
            .bind(to: descrptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isOn }
            .distinctUntilChanged()
            .bind(to: toggleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
}
