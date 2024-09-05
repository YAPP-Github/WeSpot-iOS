//
//  SignUpIntroduceViewController.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/28/24.
//

import UIKit
import Util
import Storage
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class SignUpIntroduceViewController: BaseViewController<SignUpIntroduceViewReactor> {

    //MARK: - Properties
    private let introduceLabel: WSLabel = WSLabel(wsFont: .Header01)
    private let introduceTextField: WSTextField = WSTextField(placeholder: "안녕 나는 1반의 비타민")
    private let loadingIndicatorView: WSLottieIndicatorView = WSLottieIndicatorView()
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let introduceCountLabel: WSLabel = WSLabel(wsFont: .Body07)
    private let errorLabel: WSLabel = WSLabel(wsFont: .Body07)
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(introduceLabel, introduceTextField, errorLabel, introduceCountLabel, confirmButton)
        
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        introduceTextField.snp.makeConstraints {
            $0.top.equalTo(introduceLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(introduceTextField.snp.bottom).offset(4)
            $0.left.equalTo(introduceTextField.snp.left).offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(24)
        }
        
        introduceCountLabel.snp.makeConstraints {
            $0.top.equalTo(introduceTextField.snp.bottom).offset(4)
            $0.right.equalTo(introduceTextField)
            $0.height.equalTo(20)
        }
        
        confirmButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-12)
        }
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .all(
                DesignSystemAsset.Images.arrow.image,
                "닫기",
                "",
                DesignSystemAsset.Colors.gray300.color
            ))
            $0.setNavigationBarAutoLayout(property: .all)
        }
        
        introduceLabel.do {
            guard let name = UserDefaultsManager.shared.userName else { return }
            $0.text = "친구들에게 \(name)님을 소개하는\n한 줄을 작성해 주세요"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        introduceCountLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray700.color
            $0.textAlignment = .right
        }
        
        errorLabel.do {
            $0.isHidden = true
            $0.textColor = DesignSystemAsset.Colors.destructive.color
        }
        
        confirmButton.do {
            $0.setupFont(font: .Body03)
            $0.setupButton(text: "작성 완료")
            $0.isEnabled = false
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        
        self.rx.viewWillAppear
            .bind(with: self) { owner, _ in
                owner.introduceTextField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        introduceTextField.rx.text
            .changed
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                self?.introduceTextField.updateBorder()
            })
            .compactMap { $0 }
            .map { Reactor.Action.didUpdateIntroduce($0)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedConfirmButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        introduceTextField
            .rx.text.orEmpty
            .map { "\($0.count)/20"}
            .bind(to: introduceCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.isValidation }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: errorLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.errorMessage }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: errorLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isEnabled)
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .bind(to: loadingIndicatorView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isUpdate)
            .filter { $0 == true }
            .bind(with: self) { owner, _ in
                owner.navigationController?.popToRootViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        navigationBar.rightBarButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                WSAlertBuilder(showViewController: owner)
                    .setAlertType(type: .titleWithMeesage)
                    .setTitle(title: "프로필 설정을 중단하시나요?", titleAlignment: .left)
                    .setMessage(message: "선택하셨던 캐릭터와 배경색은 저장되지 않으며 \n기본 캐릭터와 배경색으로 자동 설정됩니다")
                    .setCancel(text: "취소")
                    .setConfirm(text: "네 그만할래요")
                    .show()
            }
            .disposed(by: disposeBag)
        
    }
}
