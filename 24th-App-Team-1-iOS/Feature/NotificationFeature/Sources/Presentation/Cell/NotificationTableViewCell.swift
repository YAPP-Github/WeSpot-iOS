//
//  NotificationTableViewCell.swift
//  NotificationFeature
//
//  Created by Kim dohyun on 8/19/24.
//

import DesignSystem
import UIKit

import ReactorKit

public final class NotificationTableViewCell: UITableViewCell {
    private let alarmImageView: UIImageView = UIImageView()
    private let titleLabel: WSLabel = WSLabel(wsFont: .Body08)
    private let contentLabel: WSLabel = WSLabel(wsFont: .Body06)
    private let dateLabel: WSLabel = WSLabel(wsFont: .Body11)
    private let alarmAccessoryView: UIView = UIView()
    private let lineView: UIView = UIView()
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        alarmImageView.addSubview(alarmAccessoryView)
        contentView.addSubviews(alarmImageView, titleLabel, contentLabel, dateLabel, lineView)
    }
    
    private func setupAttributes() {
        
        self.do {
            $0.backgroundColor = .clear
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.text = "투표 알림"
            $0.textAlignment = .left
        }
        
        contentLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
    
        dateLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray400.color
            $0.textAlignment = .right
        }
        
        alarmAccessoryView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.destructive.color
            $0.layer.cornerRadius = 4 / 2
        }
        
        alarmImageView.do {
            $0.image = DesignSystemAsset.Images.icNotificationAlarmFiled.image
        }
        
        lineView.do {
            $0.backgroundColor = .separator
        }
    }
    
    private func setupAutoLayout() {
        alarmImageView.snp.makeConstraints {
            $0.size.equalTo(26)
            $0.top.equalToSuperview().inset(18)
            $0.left.equalToSuperview()
        }
        
        alarmAccessoryView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(2)
            $0.right.equalToSuperview().inset(2)
            $0.size.equalTo(4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(alarmImageView.snp.right).offset(9)
            $0.height.equalTo(20)
            $0.top.equalToSuperview().inset(18)
        }
        
        dateLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(18)
            $0.width.equalTo(80)
            $0.height.equalTo(15)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalTo(alarmImageView.snp.right).offset(9)
            $0.bottom.equalTo(lineView.snp.top).offset(-18)
            $0.right.equalTo(dateLabel.snp.left).offset(-10)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-1)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}


extension NotificationTableViewCell: ReactorKit.View {
    
    public func bind(reactor: NotificationCellReactor) {
        reactor.state
            .map { $0.content }
            .distinctUntilChanged()
            .bind(to: contentLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.date.toDate(with: .dashYyyyMMdd).toFormatRelative() }
            .distinctUntilChanged()
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isNew }
            .distinctUntilChanged()
            .bind(to: alarmAccessoryView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
}
