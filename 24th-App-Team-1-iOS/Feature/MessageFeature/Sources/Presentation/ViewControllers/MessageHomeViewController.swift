//
//  MessageHomeViewController.swift
//  MessageFeature
//
//  Created by eunseou on 7/20/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class MessageHomeViewController: BaseViewController<MessageHomeViewReactor> {
    
    //MARK: - Properties
    private let messageBannerView = WSBanner(image: DesignSystemAsset.Images.reservation.image , titleText: "예약 중인 쪽지 3개")
    private lazy var messageCardView: MessageCardView = {
        let hour = Calendar.current.component(.hour, from: Date())
        if (0..<17).contains(hour) {
            return MessageCardView(type: .morning)
        } else if (17..<22).contains(hour) {
            return MessageCardView(type: .evening)
        } else {
            return MessageCardView(type: .night)
        }
    }()
    private var isAnimating = false
    private var messageCardHeight: CGFloat {
        let hour = Calendar.current.component(.hour, from: Date())
        return (17...22).contains(hour) ? 400 : 352
    }
    private var showBanner: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return (17...24).contains(hour)
    }
    
    //MARK: - LifeCycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setInitialLayout()
        if showBanner {
            animateBanner()
        }
    }
    
    
    //MARK: - Functions
    public override func setupUI() {
        super.setupUI()
        
        if showBanner {
            view.addSubview(messageBannerView)
        }
        view.addSubview(messageCardView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        setInitialLayout()
    }
    
    private func setInitialLayout() {
        if showBanner {
            messageBannerView.snp.remakeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(-80)
                $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.height.equalTo(80)
            }
            messageCardView.snp.remakeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.height.equalTo(messageCardHeight)
            }
        } else {
            messageCardView.snp.remakeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.height.equalTo(messageCardHeight)
            }
        }
    }
    
    private func animateBanner() {
        guard !isAnimating else { return }
        isAnimating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5, animations: {
                self.messageBannerView.snp.remakeConstraints {
                    $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
                    $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(20)
                    $0.height.equalTo(80)
                }
                self.messageCardView.snp.remakeConstraints {
                    $0.top.equalTo(self.messageBannerView.snp.bottom).offset(16)
                    $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(20)
                    $0.height.equalTo(self.messageCardHeight)
                }
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.isAnimating = false
            })
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        self.rx.viewWillAppear
            .bind(with: self) { owner, _ in
                owner.messageCardView.messageLottieView.toggleAnimation(isStatus: true)
            }
            .disposed(by: disposeBag)
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        if (17..<22).contains(hour) {
            reactor.action.onNext(.fetchReceivedMessageList)
            
            reactor.pulse(\.$reservedMessages)
                .compactMap { $0 }
                .bind(to: messageBannerView.rx.reservedMessages)
                .disposed(by: disposeBag)
            
            reactor.pulse(\.$isSendAllowed)
                .compactMap { $0 }
                .bind(to: messageCardView.rx.isSendAllowed)
                .disposed(by: disposeBag)
            
            reactor.pulse(\.$reservedMessages)
                .bind(with: self) { owner, count in
                    if count == 3 {
                        owner.messageCardView.messageButton.do {
                            $0.setupButton(text: "하루에 3개까지 작성할 수 있어요")
                            $0.isEnabled = false
                        }
                    } else if count == 0 {
                        owner.messageBannerView.isHidden = true
                    } else {
                        owner.messageCardView.messageButton.do {
                            $0.setupButton(text: "익명 쪽지로 마음 표현하기")
                            $0.isEnabled = true
                        }
                        owner.messageBannerView.isHidden = false
                    }
                }
                .disposed(by: disposeBag)
        } else if (22..<24).contains(hour) {
            reactor.action.onNext(.fetchReceivedMessageList)
            
            reactor.pulse(\.$recievedMessages)
                .bind(with: self) { owner, hasMessage in
                    let showBanner = hasMessage ?? false
                    owner.messageBannerView.isHidden = !showBanner
                    
                    if showBanner {
                        owner.messageBannerView.do {
                            $0.setTitleText("익명의 쪽지가 도착했어요")
                            $0.setSubTitleText("지금 쪽지함을 열어 확인해 보세요")
                            $0.setImageView(DesignSystemAsset.Images.message.image)
                        }
                        owner.animateBanner()
                    } else {
                        owner.isAnimating = true
                        owner.setInitialLayout()
                    }
                }
                .disposed(by: disposeBag)
        }
    }
}

