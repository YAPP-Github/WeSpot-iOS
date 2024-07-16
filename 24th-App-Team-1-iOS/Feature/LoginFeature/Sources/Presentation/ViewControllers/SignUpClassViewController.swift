//
//  SignUpClassViewController.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class SignUpClassViewController: BaseViewController<SignUpClassViewReactor> {

    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Header01, text: "반")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "회원가입 이후에는 이름을 변경할 수 없어요")
    private let classTextField = WSTextField(state: .default, placeholder: "숫자로 입력해 주세요")
    private let warningLabel = WSLabel(wsFont: .Body07, text: "정확한 반을 입력해 주세요")
    private let nextButton = WSButton(wsButtonType: .default(12)).then {
        $0.setupButton(text: "다음")
    }
    //MARK: - LifeCycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        classTextField.becomeFirstResponder()
        warningLabel.isHidden = true
    }
    
    //MARK: - Functions
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(titleLabel, subTitleLabel, classTextField, warningLabel, nextButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        classTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(classTextField.snp.bottom).offset(4)
            $0.leading.equalTo(classTextField.snp.leading).offset(10)
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-12)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        navigationBar
            .setNavigationBarUI(property: .leftWithCenterItem(DesignSystemAsset.Images.arrow.image, "회원가입"))
            .setNavigationBarAutoLayout(property: .leftWithCenterItem)
        
        titleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        subTitleLabel.textColor = DesignSystemAsset.Colors.gray400.color
        
        classTextField.keyboardType = .numberPad
        classTextField.delegate = self
        
        warningLabel.textColor = DesignSystemAsset.Colors.destructive.color
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
     
        classTextField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .map { self.classTextField.isEditing }
            .bind(to: classTextField.borderUpdateBinder)
            .disposed(by: disposeBag)
        
        classTextField.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .compactMap { Int($0) }
            .map { $0 <= 20 }
            .bind(to: warningLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpGenderViewReactor = SignUpGenderViewReactor()
                let signUpGenderViewController = SignUpGenderViewController(reactor: signUpGenderViewReactor)
                owner.navigationController?.pushViewController(signUpGenderViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}

extension SignUpClassViewController: UITextFieldDelegate {
    
    // 숫자 이외의 입력 방지
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedChar = CharacterSet.decimalDigits
        let char = CharacterSet(charactersIn: string)
        return allowedChar.isSuperset(of: char)
    }
}
