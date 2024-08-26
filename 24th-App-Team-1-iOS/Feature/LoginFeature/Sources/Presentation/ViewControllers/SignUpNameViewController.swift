//
//  SignUpNameViewController.swift
//  LoginFeature
//
//  Created by eunseou on 7/11/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import Swinject
import RxSwift
import RxCocoa
import ReactorKit
import LoginDomain

public final class SignUpNameViewController: BaseViewController<SignUpNameViewReactor> {
    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Header01, text: "이름")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "회원가입 이후에는 이름을 변경할 수 없어요")
    private let nameTextField = WSTextField(state: .default, placeholder: "실명을 입력해 주세요")
    private let warningLabel = WSLabel(wsFont: .Body07)
    private let textLengthLabel = WSLabel(wsFont: .Body07)
    private let nextButton = WSButton(wsButtonType: .default(12))
    private let accountInjector: Injector = DependencyInjector(container: Container())
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false
        nameTextField.becomeFirstResponder()
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(titleLabel, subTitleLabel, nameTextField, warningLabel, textLengthLabel, nextButton)
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
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(4)
            $0.leading.equalTo(nameTextField.snp.leading).offset(10)
        }
        textLengthLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(4)
            $0.right.equalTo(nameTextField.snp.right).offset(-10)
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
        
        warningLabel.textColor = DesignSystemAsset.Colors.destructive.color
        
        textLengthLabel.textColor = DesignSystemAsset.Colors.gray400.color
        
        nextButton.do {
            $0.isEnabled = false
            $0.setupButton(text: "다음")
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        nameTextField.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.inputName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.name.count }
            .distinctUntilChanged()
            .map { "\($0)/5" }
            .bind(to: textLengthLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.errorMessage }
            .distinctUntilChanged()
            .bind(to: warningLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isWarningHidden }
            .distinctUntilChanged()
            .bind(to: warningLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isButtonEnabled }
            .distinctUntilChanged()
            .bind(with: self) { owner, isEnabled in
                owner.nextButton.isEnabled = isEnabled
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.name.count > 5 }
            .distinctUntilChanged()
            .map { $0 ? DesignSystemAsset.Colors.destructive.color : DesignSystemAsset.Colors.gray400.color }
            .bind(to: textLengthLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpResultViewController = DependencyContainer.shared.injector.resolve(SignUpResultViewController.self, arguments: reactor.currentState.accountRequest, reactor.currentState.schoolName )
                owner.navigationController?.pushViewController(signUpResultViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
