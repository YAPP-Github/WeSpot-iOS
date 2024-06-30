//
//  WSTextField.swift
//  DesignSystem
//
//  Created by eunseou on 6/29/24.
//

import UIKit

import RxSwift
import RxCocoa

final public class WSTextField: UITextField {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let defaultPadding = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    private var placeholderText: String = "Placeholder"
    
    // MARK: - init
    public init(placeholder: String = "Placeholder") {
        super.init(frame: .zero)
        
        self.placeholderText = placeholder
        setupUI()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
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
    public func applyWSFont(_ wsFont: WSFont) {
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
    
    // 텍스트 필드의 텍스트 영역에 패딩을 적용
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by:defaultPadding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: defaultPadding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: defaultPadding)
    }

    
}
