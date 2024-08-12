//
//  ProfileSettingViewController.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/12/24.
//

import DesignSystem
import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class ProfileSettingViewController: BaseViewController<ProfileSettingViewReactor> {

    //MARK: - Properties
    private let scrollView: UIScrollView = UIScrollView()
    private let containerView: UIView = UIView()
    private let userContainerView: UIView = UIView()
    private let userImageView: UIImageView = UIImageView()
    private let userProfileEditButton: UIButton = UIButton(type: .custom)
    private let userNameTextField: WSTextField = WSTextField(state: .withRightItem(DesignSystemAsset.Images.lock.image), placeholder: "김선희", title: "이름")
    private let userGenderTextFiled: WSTextField = WSTextField(state: .withRightItem(DesignSystemAsset.Images.lock.image), placeholder: "여", title: "성별")
    private let userClassInfoTextField: WSTextField = WSTextField(state: .withRightItem(DesignSystemAsset.Images.lock.image), placeholder: "역삼중학교 1학년 6반", title: "학적 정보")
    private let userIntroduceTextField: WSTextField = WSTextField(state: .default, placeholder: "안녕 난 선희다", title: "한줄 소개")
    private let editButton: WSButton = WSButton(wsButtonType: .default(12))
    private let errorLabel: WSLabel = WSLabel(wsFont: .Body07)
    private let introduceCountLabel: WSLabel = WSLabel(wsFont: .Body07)
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .hideTabBar, object: nil)
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        userContainerView.addSubview(userImageView)
        containerView.addSubviews(userContainerView, userProfileEditButton, userNameTextField, userGenderTextFiled, userClassInfoTextField, userIntroduceTextField, errorLabel, introduceCountLabel)
        scrollView.addSubview(containerView)
        view.addSubviews(scrollView, editButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        userContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.size.equalTo(90)
            $0.centerX.equalToSuperview()
        }
        
        userProfileEditButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.bottom.equalTo(userContainerView)
            $0.right.equalTo(userContainerView)
        }
        
        userImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        userNameTextField.snp.makeConstraints {
            $0.top.equalTo(userContainerView.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        userGenderTextFiled.snp.makeConstraints {
            $0.top.equalTo(userNameTextField.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        userClassInfoTextField.snp.makeConstraints {
            $0.top.equalTo(userGenderTextFiled.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        userIntroduceTextField.snp.makeConstraints {
            $0.top.equalTo(userClassInfoTextField.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(userIntroduceTextField.snp.bottom).offset(4)
            $0.left.equalTo(userIntroduceTextField.snp.left).offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(24)
        }
        
        introduceCountLabel.snp.makeConstraints {
            $0.top.equalTo(userIntroduceTextField.snp.bottom).offset(4)
            $0.right.equalTo(userIntroduceTextField.snp.right).offset(-4)
            $0.height.equalTo(24)
            $0.width.equalTo(55)
        }
        
        editButton.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftWithCenterItem(
                DesignSystemAsset.Images.arrow.image,
                "프로필 수정"
            ))
            $0.setNavigationBarAutoLayout(property: .leftWithCenterItem)
        }

        editButton.do {
            $0.setupFont(font: .Body03)
            $0.setupButton(text: "개인정보 변경 신청")
        }
        
        userContainerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.primary300.color
            $0.layer.cornerRadius = 90 / 2
            $0.clipsToBounds = true
        }
        
        introduceCountLabel.do {
            $0.text = "0/20"
            $0.textColor = DesignSystemAsset.Colors.gray400.color
            $0.textAlignment = .right
        }
        
        errorLabel.do {
            $0.isHidden = true
            $0.text = "비속어 포함 되어있습니다."
            $0.textColor = DesignSystemAsset.Colors.destructive.color
        }
        
        userProfileEditButton.do {
            $0.configuration = .filled()
            $0.layer.cornerRadius = 24 / 2
            $0.clipsToBounds = true
            $0.configuration?.baseBackgroundColor = DesignSystemAsset.Colors.gray400.color
            $0.configuration?.image = DesignSystemAsset.Images.icProfileEditSelected.image
        }
        
        userImageView.do {
            $0.image = DesignSystemAsset.Images.girl.image
        }
        
        userNameTextField.do {
            $0.isEnabled = false
        }
        
        userGenderTextFiled.do {
            $0.isEnabled = false
        }
        
        userClassInfoTextField.do {
            $0.isEnabled = false
        }
        
        scrollView.do {
            $0.canCancelContentTouches = true
        }
        
        
    }
    
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        
        containerView
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.containerView.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        userIntroduceTextField
            .rx.text.changed
            .compactMap { $0 }
            .map { Reactor.Action.didUpdateIntroduceProfile($0)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        userIntroduceTextField
            .rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .map { self.userIntroduceTextField.isEditing }
            .bind(to: userIntroduceTextField.borderUpdateBinder)
            .disposed(by: disposeBag)
        
        NotificationCenter.default
            .rx.notification(UIResponder.keyboardWillShowNotification, object: nil)
            .compactMap { $0.userInfo }
            .map { userInfo -> CGFloat in
                return (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }
            .bind(with: self) { owner, height in
                if owner.userIntroduceTextField.isEditing {
                    owner.containerView.frame.origin.y -= (height - 52)
                }
            }
            .disposed(by: disposeBag)
        
        NotificationCenter.default
            .rx.notification(UIResponder.keyboardWillHideNotification, object: nil)
            .bind(with: self) { owner, _ in
                owner.containerView.frame.origin.y = 0
            }
            .disposed(by: disposeBag)
        
        
        reactor.pulse(\.$isProfanity)
            .map { !$0 }
            .bind(to: errorLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.errorMessage }
            .distinctUntilChanged()
            .bind(to: errorLabel.rx.text)
            .disposed(by: disposeBag)
        
        userIntroduceTextField
            .rx.text.orEmpty
            .map { "\($0.count)/20" }
            .bind(to: introduceCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        
    }
}
