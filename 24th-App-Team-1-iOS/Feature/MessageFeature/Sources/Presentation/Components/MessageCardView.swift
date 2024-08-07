//
//  MessageCardView.swift
//  MessageFeature
//
//  Created by eunseou on 8/8/24.
//

import UIKit
import DesignSystem

import SnapKit
import RxSwift
import RxCocoa

public final class MessageCardView: UIView {

    public enum CardTimeType {
        case morning
        case evening
        case night
    }
    
    // MARK: - Properties
    private let messageContanierView = UIView()
    private let messageImageView = UIImageView()
    private let messageTitleLabel = WSLabel(wsFont: .Body01)
    private let messageButton = WSButton(wsButtonType: .default(12))
    private let messageTimerNoticeLabel = WSLabel(wsFont: .Body09, text: "쪽지 전달까지 남은 시간")
    private let messageTimerImageView = UIImageView()
    private let messageTimerLabel = UILabel()
    private let messageContainerUnderLabel = WSLabel(wsFont: .Body06)
    
    private let endTime = Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date())!
    
    // MARK: - Initialize
    public init(type: CardTimeType) {
        super.init(frame: .zero)
        
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
        addSubviews(messageContanierView, messageContainerUnderLabel)
        messageContanierView.addSubviews(messageImageView, messageTitleLabel, messageTimerNoticeLabel,messageTimerImageView, messageTimerLabel, messageButton)
    }
    
    private func setupAttributes() {
        
        messageContanierView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.layer.cornerRadius = 18
        }
        
        messageImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = DesignSystemAsset.Images.imgMessageHomeLetterOpen.image
        }
        
        messageTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "당신을 설레게 한 친구에게\n익명 쪽지로 마음을 표현해보세요"
        }
        
        messageContainerUnderLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray200.color
            $0.text = "서로의 쪽지는 밤 10시에 전달해드릴게요"
        }
        
        messageTimerNoticeLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        messageTimerImageView.do {
            $0.image = DesignSystemAsset.Images.icMessageHomeTimer.image
        }
        
        messageTimerLabel.do {
            $0.font = DesignSystemFontFamily.Pretendard.bold.font(size: 28)
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "3:34:20"
        }
        
        messageButton.do {
            $0.setupButton(text: "익명 쪽지로 마음 표현하기")
        }
    }
    
    private func setupAutoLayout() {
        
        messageContanierView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        messageContainerUnderLabel.snp.makeConstraints {
            $0.top.equalTo(messageContanierView.snp.bottom).offset(12)
            $0.centerX.equalTo(messageContanierView)
        }
        
        messageTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.height.equalTo(54)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        messageImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(messageImageView.snp.width)
        }
        
        messageTimerNoticeLabel.snp.makeConstraints {
            $0.bottom.equalTo(messageTimerLabel.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        messageTimerImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(105)
            $0.size.equalTo(20)
            $0.centerY.equalTo(messageTimerLabel)
        }
        
        messageTimerLabel.snp.makeConstraints {
            $0.leading.equalTo(messageTimerImageView.snp.trailing).offset(10)
            $0.height.equalTo(39)
            $0.bottom.equalToSuperview().inset(92)
        }
        
        messageButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(28)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
    }
}
