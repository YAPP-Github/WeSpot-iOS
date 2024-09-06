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
    private lazy var blurView: UIBlurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
    private lazy var visualEffectView: UIVisualEffectView = UIVisualEffectView(effect: blurView)
    
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
        addSubviews(visualEffectView, landingLottieView)
    }
    
    private func setupAutoLayout() {
        visualEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        landingLottieView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(375)
            $0.center.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        
        visualEffectView.do {
            $0.frame = bounds
            $0.backgroundColor = .black.withAlphaComponent(0.1)
            $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        landingLottieView.do {
            $0.lottieView.loopMode = .loop
            $0.lottieView.animation = DesignSystemAnimationAsset.bgVoteSwipeAnimate.animation
            $0.isStatus = true
        }
    }
}
