//
//  WSTextField.swift
//  DesignSystem
//
//  Created by eunseou on 6/29/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

public final class WSTextField: UITextField {
    
    public enum TextFieldState {
        case `default`
        case withLeftItem(UIImage)
        case withRightItem(UIImage)
        
        var padding: UIEdgeInsets {
            switch self {
            case .default:
                    .init(top: 18, left: 18, bottom: 18, right: 18)
            case .withLeftItem:
                    .init(top: 18, left: 59, bottom: 18, right: 18)
            case .withRightItem:
                    .init(top: 18, left: 20, bottom: 18, right: 48)
            }
        }
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var placeholderText: String = "Placeholder"
    private var titleText: String?
    private var textFieldState: TextFieldState = .default
    
    // MARK: - Components
    private let titleLabel =  WSLabel(wsFont: .Body04, textAlignment: .left).then {
        $0.textColor = DesignSystemAsset.Colors.gray100.color
    }
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    
    // MARK: - Initializer
    public init(state: TextFieldState = .default, placeholder: String = "Placeholder", title: String? = nil) {
        super.init(frame: .zero)
        
        self.textFieldState = state
        self.titleText = title
        self.placeholderText = placeholder
        setupUI()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
        
        switch textFieldState {
        case .default:
            break
        case .withLeftItem(let image):
            setupImageView(image, isLeft: true)
        case .withRightItem(let image):
            setupImageView(image, isLeft: false)
        }
        
        if let titleText = titleText {
            setupTitleLabel(with: titleText)
        }
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 12
        placeholder = placeholderText
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: DesignSystemAsset.Colors.gray400.color])
        backgroundColor = DesignSystemAsset.Colors.gray700.color
        applyWSFont(.Body04)
    }
    
    private func bindUI() {
        
        rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .subscribe(with: self) { owner, _ in
                owner.updateBorder()
            }.disposed(by: disposeBag)
        
        rx.text.orEmpty
            .subscribe(with: self) { owner, text in
                owner.updateTextColor(hasText: !text.isEmpty)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateBorder() {
        if isEditing {
            layer.borderColor = DesignSystemAsset.Colors.primary400.color.cgColor
        } else {
            layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    private func updateTextColor(hasText: Bool) {
        if hasText {
            textColor = DesignSystemAsset.Colors.gray100.color
        } else {
            textColor = DesignSystemAsset.Colors.gray400.color
        }
    }
    
    // WSFont를 적용하는 메소드 추가
    private func applyWSFont(_ wsFont: WSFont) {
        self.font = wsFont.font()
        
        if let text = self.text, !text.isEmpty {
            let attributedString = NSAttributedString(string: text, attributes: wsFontAttributes(wsFont))
            attributedText = attributedString
        }
    }
    
    private func wsFontAttributes(_ wsFont: WSFont) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        let lineHeight = wsFont.size * wsFont.lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.lineHeightMultiple = wsFont.lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let baselineOffset = (lineHeight - wsFont.size) / 2
        return [
            .font: wsFont.font(),
            .paragraphStyle: paragraphStyle,
            .baselineOffset: baselineOffset
        ]
    }
    
    // title Label 레이아웃 설정
    private func setupTitleLabel(with titleText: String) {
        addSubview(titleLabel)
        titleLabel.text = titleText
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.snp.top).offset(-12)
        }
    }
    
    // UIImageView 레이아웃 설정
    private func setupImageView(_ image: UIImage, isLeft: Bool) {
        imageView.image = image
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            if isLeft {
                $0.leading.equalToSuperview().offset(16)
            } else {
                $0.trailing.equalToSuperview().offset(-8)
            }
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }
    }

    
    // 텍스트 필드의 텍스트 영역에 패딩을 적용
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldState.padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldState.padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textFieldState.padding)
    }
    
    
}
