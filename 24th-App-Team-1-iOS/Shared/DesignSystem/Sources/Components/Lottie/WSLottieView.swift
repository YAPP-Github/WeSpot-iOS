//
//  WSLottieView.swift
//  DesignSystem
//
//  Created by Kim dohyun on 7/16/24.
//

import UIKit

import Lottie
import Then
import SnapKit

public final class WSLottieView: UIView {
    
    //MARK: - Properties
    private let lottieView: LottieAnimationView = LottieAnimationView()
    public var isStauts: Bool = true {
        didSet { toggleAnimation(isStatus: isStauts) }
    }
    public var wsAnimation: LottieAnimation? = DesignSystemAnimationAsset.demo.animation
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configure
    private func setupUI() {
        addSubview(lottieView)
    }
    
    private func setupAutoLayout() {
        lottieView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //TODO: 테스트 코드
    /// - 반복 횟수, 애니메이션 속도 논의 후 설정 코드 추가
    private func setupAttributes() {
        lottieView.do {
            $0.loopMode = .loop
            $0.animation = wsAnimation
        }
        
    }
    
    private func toggleAnimation(isStatus: Bool) {
        isStatus ? lottieView.play() : lottieView.stop()
    }
}
