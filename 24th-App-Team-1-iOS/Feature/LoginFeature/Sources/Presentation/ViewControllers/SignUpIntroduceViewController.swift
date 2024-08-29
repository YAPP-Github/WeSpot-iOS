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
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let introduceCountLabel: WSLabel = WSLabel(wsFont: .Body07)
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(introduceLabel, introduceTextField, introduceCountLabel, confirmButton)
        
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
        
        introduceCountLabel.snp.makeConstraints {
            $0.top.equalTo(introduceTextField.snp.bottom).offset(4)
            $0.right.equalTo(introduceTextField)
            $0.height.equalTo(20)
        }
        
        confirmButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.bottom).offset(12)
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
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        
        introduceTextField
            .rx.text.orEmpty
            .map { "\($0.count)/20"}
            .bind(to: introduceCountLabel.rx.text)
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
