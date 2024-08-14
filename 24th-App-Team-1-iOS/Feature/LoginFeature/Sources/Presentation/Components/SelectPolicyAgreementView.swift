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
    public let checkButton = UIButton()
    private let titleLabel = WSLabel(wsFont: .Body06)
    public let moreDetailButton = UIButton()
    private let isCheckedRelay = BehaviorRelay<Bool>(value: false)
    public var isCheckedObservable: Observable<Bool> {
        return isCheckedRelay.asObservable()
    }
    
    private var isChecked: Bool {
        get { return isCheckedRelay.value }
        set {
            isCheckedRelay.accept(newValue)
        }
    }
    private let disposeBag = DisposeBag()
    
    //MARK: - Initializer
    public init(text: String, font: WSFont = .Body06, isHiddenDetailButton: Bool = false) {
        super.init(frame: .zero)
        
        setupUI()
        setupAutoLayout()
        setupAttributes()
        setupDetail(text: text, font: font, isHidden: isHiddenDetailButton)
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    private func setupUI() {
        
        addSubviews(checkButton, titleLabel, moreDetailButton)
    }
    
    private func setupAutoLayout() {
        
        checkButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().offset(7)
            $0.size.equalTo(25)
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkButton)
            $0.leading.equalTo(checkButton.snp.trailing).offset(7)
        }
        moreDetailButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
    
    private func setupAttributes() {
        
        titleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        moreDetailButton.setImage(DesignSystemAsset.Images.arrowRight.image, for: .normal)
    }
    
    private func setupDetail(text: String, font: WSFont, isHidden: Bool) {
    
        checkButton.setImage(DesignSystemAsset.Images.check.image, for: .normal)
        checkButton.setImage(DesignSystemAsset.Images.checkSelected.image, for: .highlighted)
        
        titleLabel.text = text
        titleLabel.font = font.font()
        
        moreDetailButton.isHidden = isHidden
    }
    
    private func bindUI() {
        
        checkButton.rx.tap
            .withLatestFrom(isCheckedRelay)
            .map { !$0 }
            .bind(to: isCheckedRelay)
            .disposed(by: disposeBag)
        
        isCheckedRelay
            .map { $0 ? DesignSystemAsset.Images.checkSelected.image : DesignSystemAsset.Images.check.image }
            .bind(to: checkButton.rx.image(for: .normal))
            .disposed(by: disposeBag)
    }
    
    public func setCheckedState(_ isChecked: Bool) {
        isCheckedRelay.accept(isChecked)
    }

}
