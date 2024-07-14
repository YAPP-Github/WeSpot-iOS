//
//  GradientView.swift
//  LoginFeature
//
//  Created by eunseou on 7/13/24.
//

import UIKit

import DesignSystem

final public class GradientView: UIView {

    //MARK: - Properties
    let gradientLayer = CAGradientLayer()
    let gradientColor: [CGColor] = [
        UIColor.clear.cgColor,
        DesignSystemAsset.Colors.gray900.color.cgColor
     ]
    
    //MARK: - Initializer
    public init() {
        super.init(frame: .zero)
        
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    private func setupGradientLayer() {
        
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientColor
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
