//
//  WSIntensityVisualEffectView.swift
//  DesignSystem
//
//  Created by Kim dohyun on 8/21/24.
//

import UIKit


public final class WSIntensityVisualEffectView: UIVisualEffectView {
    private let theEffect: UIVisualEffect
    private let customIntensity: CGFloat
    private var animator: UIViewPropertyAnimator?
    
    
    public init(effect: UIVisualEffect, intensity: CGFloat) {
        theEffect = effect
        customIntensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        animator?.stopAnimation(true)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [weak self] in
            guard let self else { return }
            self.effect = theEffect
        }
        animator?.fractionComplete = customIntensity
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.animator?.stopAnimation(true)
            self.animator?.finishAnimation(at: .current)
        }
    }
}
