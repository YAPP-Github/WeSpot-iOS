//
//  GenderCardView.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import UIKit
import DesignSystem

import SnapKit

public final class GenderCardButton: UIButton {
    
    //MARK: - Gender Case
    public enum GenderType {
        case boy
        case girl
    
        var name: String {
            switch self {
            case .boy:
                return "남학생"
            case .girl:
                return "여학생"
            }
        }
        
        var image: UIImage {
            switch self {
            case .boy:
                return DesignSystemAsset.Images.boy.image
            case .girl:
                return DesignSystemAsset.Images.girl.image
            }
        }
    }
    
    //MARK: - Properties
    private let cardImage = UIImageView()
    private let typeLabel = WSLabel(wsFont: .Header02, textAlignment: .center)
    
    private var image: UIImage? {
        return cardImage.image
    }
    public override var isHighlighted: Bool {
        didSet { updateBorder() }
    }
    
    //MARK: - Initializer
    public init(type: GenderType) {
        super.init(frame: .zero)
        
        setupUI()
        setupAutoLayout()
        setupAttributes(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupUI() {
        addSubviews(cardImage, typeLabel)
    }
    
    private func setupAutoLayout() {
        cardImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.horizontalEdges.equalToSuperview().inset(31)
            $0.size.equalTo(90)
        }
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(cardImage.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-17)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupAttributes(type: GenderType) {
        backgroundColor = DesignSystemAsset.Colors.gray700.color
        layer.cornerRadius = 16
        
        cardImage.image = type.image
        typeLabel.text = type.name
        typeLabel.textColor = DesignSystemAsset.Colors.gray100.color
    }
    
    private func updateBorder() {
        layer.borderColor = isHighlighted ? DesignSystemAsset.Colors.primary400.color.cgColor : UIColor.clear.cgColor
        layer.borderWidth = isHighlighted ? 1 : 0
    }
}
