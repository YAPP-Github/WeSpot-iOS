//
//  VoteCompleteOnBoardingView.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/24/24.
//

import DesignSystem
import UIKit


final class VoteCompleteOnBoardingView: UIView {
    
    private let descrptionLabel: WSLabel = WSLabel(wsFont: .Header01, text: "우리 반 투표 결과를 분석하고 있어요")
    private let onboardingLottieView: WSLottieView = WSLottieView()
    
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
        addSubviews(descrptionLabel, onboardingLottieView)
    }
    
    private func setupAutoLayout() {
        
        descrptionLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(30)
        }
        
        onboardingLottieView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(450)
            $0.top.equalTo(descrptionLabel.snp.bottom).offset(54)
        }
    }
    
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray900.color
        }
        
        onboardingLottieView.do {
            $0.lottieView.animation = DesignSystemAnimationAsset.bgVoteFindAnimate.animation
            $0.lottieView.loopMode = .loop
            $0.isStauts = true
        }
        
        descrptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
    }
}
