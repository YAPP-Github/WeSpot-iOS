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
    public let messageButton = WSButton(wsButtonType: .default(12))
    private let messageTimerNoticeLabel = WSLabel(wsFont: .Body09, text: "쪽지 전달까지 남은 시간")
    private let messageTimerImageView = UIImageView()
    private let messageTimerLabel = UILabel()
    private let messageContainerUnderLabel = WSLabel(wsFont: .Body06)
    private var type: CardTimeType
    private let endTime = Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date())!
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    public init(type: CardTimeType) {
        self.type = type
        super.init(frame: .zero)
        
        setupUI()
        setupAttributes()
        setupAutoLayout()
        configureView(type: type)
        startTimer()
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
        }
        
        messageContainerUnderLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray200.color
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

    private func configureView(type: CardTimeType) {
        switch type {
        case .morning:
            messageTimerNoticeLabel.isHidden = true
            messageTimerImageView.isHidden = true
            messageTimerLabel.isHidden = true
            messageImageView.image = DesignSystemAsset.Images.imgMessageHomeLetterOpen.image
            messageTitleLabel.text = "당신을 설레게 한 친구에게\n익명 쪽지로 마음을 표현해보세요"
            messageContainerUnderLabel.text = ""
            messageButton.do {
                $0.setupButton(text: "매일 저녁 5시에 쪽지를 보낼 수 있어요")
                $0.isEnabled = false
            }
            
        case .evening:
            messageTimerNoticeLabel.isHidden = false
            messageTimerImageView.isHidden = false
            messageTimerLabel.isHidden = false
            messageImageView.image = DesignSystemAsset.Images.imgMessageHomeLetterOpen.image
            messageTitleLabel.text = "당신을 설레게 한 친구에게\n익명 쪽지로 마음을 표현해보세요"
            messageContainerUnderLabel.text = "서로의 쪽지는 밤 10시에 전달해드릴게요"
            messageButton.do {
                $0.setupButton(text: "익명 쪽지로 마음 표현하기")
            }
            
        case .night:
            messageTimerNoticeLabel.isHidden = true
            messageTimerImageView.isHidden = true
            messageTimerLabel.isHidden = true
            messageImageView.image = DesignSystemAsset.Images.imgMessageHomeLetterClose.image
            messageTitleLabel.text = "모두의 소중한 마음이\n상대에게 무사히 전달되었어요"
            messageContainerUnderLabel.text = "내일 저녁 5시에 새로운 쪽지를 보낼 수 있어요"
            messageButton.do {
                $0.setupButton(text: "매일 저녁 5시에 쪽지를 보낼 수 있어요")
                $0.isEnabled = false
            }
        }
    }
    
    private func startTimer() {
        if type == .evening {
            Observable<Int>
                .interval(.seconds(1), scheduler: MainScheduler.instance)
                .flatMapLatest { [weak self] _ -> Observable<String> in
                    guard let self = self else { return .just("") }
                    let now = Date()
                    let remainTime = self.endTime.timeIntervalSince(now)
                    if remainTime <= 0 {
                        return .just("00:00:00")
                    }
                    let hours = Int(remainTime) / 3600
                    let minutes = (Int(remainTime) % 3600) / 60
                    let seconds = Int(remainTime) % 60
                    let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                    return .just(timeString)
                }
                .bind(to: messageTimerLabel.rx.text)
                .disposed(by: disposeBag)
        }
    }
}
