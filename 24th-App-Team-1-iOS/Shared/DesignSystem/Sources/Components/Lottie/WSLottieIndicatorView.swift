//
//  WSLottieIndicatorView.swift
//  DesignSystem
//
//  Created by Kim dohyun on 8/20/24.
//

import UIKit

import Lottie
import Then
import SnapKit


public final class WSLottieIndicatorView: UIView {
    public let lottieIndicatorView: LottieAnimationView = LottieAnimationView()

    public override var isHidden: Bool {
        didSet {
            if isHidden {
                hide()
                print("lotti indicator hidden")
            } else {
                show()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(lottieIndicatorView)
    }
    
    private func setupAutoLayout() {
        
        lottieIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
        }
    }
    
    private func setupAttributes() {
        lottieIndicatorView.do {
            $0.loopMode = .loop
            $0.animation = DesignSystemAnimationAsset.bgCommonLoading.animation
        }
    }
    
    
    private func show() {
        guard let window  = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return }
        self.frame = window.bounds
        
        window.addSubview(self)
        lottieIndicatorView.play()
    }
    
    
    private func hide() {
        print("is hide mentod call")
        lottieIndicatorView.stop()
        self.removeFromSuperview()
        
    }
    
}
