//
//  WSBanner.swift
//  DesignSystem
//
//  Created by eunseou on 7/5/24.
//

import UIKit

import SnapKit
import Then

public final class WSBanner: UIView {
    
    //MARK: - Compnents
    private let imageView = UIImageView()
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .center
        $0.distribution = .fill
    }
    private let labelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .leading
    }
    private let titleLabel = WSLabel(wsFont: .Body04).then {
        $0.textColor = DesignSystemAsset.Colors.gray100.color
    }
    private let subLabel = WSLabel(wsFont: .Body07).then {
        $0.textColor = DesignSystemAsset.Colors.primary300.color
    }
    public let arrowButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Images.arrowRight.image, for: .normal)
    }
    
    //MARK: - Properties
    private var image: UIImage? = nil
    private var subText: String? = nil
    
    
    //MARK: - Initializer
    public init(image: UIImage? = nil, titleText: String, subText: String? = nil) {
        super.init(frame: .zero)
        
        self.image = image
        self.titleLabel.text = titleText
        self.subLabel.text = subText
        
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupUI() {
        
        addSubviews(stackView, arrowButton)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subLabel)
    }
    
    private func setupAttributes() {
        
        backgroundColor = DesignSystemAsset.Colors.gray600.color
        layer.cornerRadius = 14
        
        imageView.image = image
        imageView.isHidden = (image == nil)
        
        subLabel.isHidden = (subText != nil)
    }
    
    private func setupAutoLayout() {
        
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.greaterThanOrEqualTo(arrowButton.snp.leading).offset(-5)
        }
        arrowButton.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    // 외부에서 접근 가능한 배경 색상 변경 함수
    public func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    // 외부에서 접근 가능한 테두리 설정 함수
    public func setBorderColor() {
        layer.borderColor = DesignSystemAsset.Colors.primary400.color.cgColor
        layer.borderWidth = 0.6
    }
    
    // 외부에서 접근 가능한 subLabel 색상 변경 함수
    public func setSubLabelColor(_ color: UIColor) {
        subLabel.textColor = color
    }
    
    // titleLabel 업데이트 함수
    public func setTitleText(_ text: String) {
        titleLabel.text = text
    }
    
    // subLabel 업데이트 함수
    public func setSubTitleText(_ text: String) {
        subLabel.text = text
    }
    
    // image 업데이트 함수
    public func setImageView(_ image: UIImage) {
        imageView.image = image
    }
}
