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
    public let lottieView: LottieAnimationView = LottieAnimationView()
    public var isStatus: Bool = true {
        didSet { toggleAnimation(isStatus: isStatus) }
    }
    public var wsAnimation: LottieAnimation?
    
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
    private func setupAttributes() {
        lottieView.do {
            $0.loopMode = .loop
        }
        
    }
    
    public func toggleAnimation(isStatus: Bool) {
        isStatus ? lottieView.play() : lottieView.stop()
    }
}
