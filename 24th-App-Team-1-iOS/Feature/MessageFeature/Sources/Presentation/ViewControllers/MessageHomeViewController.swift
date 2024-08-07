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
    private let messageBannerView = WSBanner(image: DesignSystemAsset.Images.reservation.image ,titleText: "예약 중인 쪽지 3개")
    private let messageCardView = MessageCardView(type: .evening)
    private var isAnimating = false
    
    //MARK: - LifeCycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setInitialLayout()
        animateBanner()
    }
    
    
    //MARK: - Functions
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(messageBannerView, messageCardView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        setInitialLayout()
    }
    
    private func setInitialLayout() {
        messageBannerView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-80)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(80)
        }
        
        messageCardView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(400)
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
                    $0.height.equalTo(400)
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
        
    }
}
