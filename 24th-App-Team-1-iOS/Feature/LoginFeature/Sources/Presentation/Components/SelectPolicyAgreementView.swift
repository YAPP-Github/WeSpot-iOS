//
//  SelectPolicyAgreementView.swift
//  LoginFeature
//
//  Created by eunseou on 7/15/24.
//

import UIKit
import DesignSystem

import SnapKit
import RxSwift
import RxCocoa

final public class SelectPolicyAgreementView: UIView {

    //MARK: - Properties
    let checkButton = UIButton()
    let policyButton = UIButton(type: .custom)
    let moreDetailButton = UIButton()
    var isChecked: Bool = false {
        didSet {
            checkButton.isSelected = isChecked
        }
    }
    private let disposeBag = DisposeBag()
    
    //MARK: - Initializer
    public init(text: String, font: WSFont = .Body06, isHiddenDetailButton: Bool = false) {
        super.init(frame: .zero)
        
        setupUI()
        setupAutoLayout()
        setupAttributes(text: text, font: font)
        setupDetail(isHidden: isHiddenDetailButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    private func setupUI() {
        
        addSubviews(checkButton, policyButton, moreDetailButton)
    }
    
    private func setupAutoLayout() {
        
        checkButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().offset(7)
            $0.size.equalTo(25)
        }
        policyButton.snp.makeConstraints {
            $0.centerY.equalTo(checkButton)
            $0.leading.equalTo(checkButton.snp.trailing).offset(7)
        }
        moreDetailButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
    
    private func setupAttributes(text: String, font: WSFont) {
        policyButton.do {
            $0.configuration = .filled()
            $0.configuration?.baseBackgroundColor = .clear
            $0.configuration?.baseForegroundColor = DesignSystemAsset.Colors.gray100.color
            $0.configuration?.attributedTitle = AttributedString(NSAttributedString(string: text, attributes: [
                .font: font.font(),
            ]))
        }
        
        
        moreDetailButton.setImage(DesignSystemAsset.Images.arrowRight.image, for: .normal)
    }
    
    private func setupDetail(isHidden: Bool) {
    
        checkButton.setImage(DesignSystemAsset.Images.check.image, for: .normal)
        checkButton.setImage(DesignSystemAsset.Images.checkSelected.image, for: .selected)
        
        
        moreDetailButton.isHidden = isHidden
    }
}
