//
//  WSToast.swift
//  DesignSystem
//
//  Created by eunseou on 7/6/24.
//

import UIKit

import SnapKit
import Then

public enum ToastImagesType {
    case check
    case warning
    
    var images: UIImage {
        switch self {
        case .check:
            DesignSystemAsset.Images.checkmarkFillPositive.image
        case .warning:
            DesignSystemAsset.Images.exclamationmarkFillDestructive.image
        }
    }
}

public final class WSToast: UIView {

    // MARK: - Properties
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fill
    }
    private let imageView = UIImageView()
    private let messageLabel = WSLabel(wsFont: .Body06)
    
    // MARK: - Initialize
    public init(image: ToastImagesType, text: String) {
        super.init(frame: .zero)
        
        imageView.image = image.images
        messageLabel.text = text
        
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
        
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(messageLabel)
    }
    private func setupAutoLayout() {
        
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(14)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
    }
    private func setupAttributes() {
        
        clipsToBounds = true
        backgroundColor = UIColor.white
        messageLabel.textColor = DesignSystemAsset.Colors.gray900.color
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
    }
    
}
