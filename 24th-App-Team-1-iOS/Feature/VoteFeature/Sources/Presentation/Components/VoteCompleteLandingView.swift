//
//  VoteCompleteLandingView.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/24/24.
//

import DesignSystem
import UIKit

import RxSwift
import RxCocoa


final class VoteCompleteLandingView: UIView {
    
    private let landingLottieView: WSLottieView = WSLottieView()
    private let landingBlurEffectView: UIBlurEffect = UIBlurEffect(style: .dark)
    private lazy var landingBlurView: WSIntensityVisualEffectView = WSIntensityVisualEffectView(effect: landingBlurEffectView, intensity: 0.3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(landingBlurView, landingLottieView)
    }
    
    private func setupAutoLayout() {
        landingBlurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        landingLottieView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(375)
            $0.center.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        
        landingLottieView.do {
            $0.lottieView.loopMode = .loop
            $0.lottieView.animation = DesignSystemAnimationAsset.bgVoteSwipeAnimate.animation
            $0.isStatus = true
        }
    }
}
