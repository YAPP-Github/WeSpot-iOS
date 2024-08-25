//
//  SignUpResultViewController.swift
//  LoginFeature
//
//  Created by eunseou on 7/13/24.
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

public final class SignUpResultViewController: BaseViewController<SignUpResultViewReactor> {
    
    //MARK: - Properties
    private let nameTextField = WSTextField(state: .default, title: "이름")
    private let genderTextField = WSTextField(state: .default, title: "성별")
    private let classTextField = WSTextField(state: .default, title: "반")
    private let gradeTextField = WSTextField(state: .default, title: "학년")
    private let schoolTextField = WSTextField(state: .default, title: "학교")
    private let nameTextFieldTapGesture = UITapGestureRecognizer()
    private let genderTextFieldTapGesture = UITapGestureRecognizer()
    private let classTextFieldTapGesture = UITapGestureRecognizer()
    private let gradeTextFieldTapGesture = UITapGestureRecognizer()
    private let schoolTextFieldTapGesture = UITapGestureRecognizer()
    private let comfirmInfoBottomSheetView = ConfirmInfoBottomSheetView()
    private let policyAgreementBottomSheetView = PolicyAgreementBottomSheetView()
    private let dimView = UIView()
    private let nextButton = WSButton(wsButtonType: .default(12))
    private let accountInjector: Injector = DependencyInjector(container: Container())
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomSheet()
        showComfirmInfoBottomSheet()
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(nameTextField, genderTextField, classTextField, gradeTextField, schoolTextField, nextButton, dimView, comfirmInfoBottomSheetView, policyAgreementBottomSheetView)
        nameTextField.addGestureRecognizer(nameTextFieldTapGesture)
        genderTextField.addGestureRecognizer(genderTextFieldTapGesture)
        classTextField.addGestureRecognizer(classTextFieldTapGesture)
        gradeTextField.addGestureRecognizer(gradeTextFieldTapGesture)
        schoolTextField.addGestureRecognizer(schoolTextFieldTapGesture)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(36)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        genderTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(52)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        classTextField.snp.makeConstraints {
            $0.top.equalTo(genderTextField.snp.bottom).offset(52)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        gradeTextField.snp.makeConstraints {
            $0.top.equalTo(classTextField.snp.bottom).offset(52)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        schoolTextField.snp.makeConstraints {
            $0.top.equalTo(gradeTextField.snp.bottom).offset(52)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        comfirmInfoBottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(304)
        }
        policyAgreementBottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(412)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftWithCenterItem(DesignSystemAsset.Images.arrow.image, "회원가입"))
            $0.setNavigationBarAutoLayout(property: .leftWithCenterItem)
        }
        
        dimView.do{
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }
        
        nextButton.do {
            $0.setupButton(text: "다음")
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        reactor.state
            .map { $0.accountRequest.name }
            .bind(to: nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.accountRequest.gender }
            .map{ gender in
                if gender == "female" { return "여학생" }
                else { return "남학생" }
            }
            .bind(to: genderTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.accountRequest.classNumber }
            .map { "\($0)" }
            .bind(to: classTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.accountRequest.grade }
            .map { "\($0)학년"}
            .bind(to: gradeTextField.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.schoolName }
            .bind(to: schoolTextField.rx.text)
            .disposed(by: disposeBag)
        
        nameTextFieldTapGesture.rx.event
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpNameViewController = DependencyContainer.shared.injector.resolve(SignUpNameViewController.self)
                owner.navigationController?.pushViewController(signUpNameViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        genderTextFieldTapGesture.rx.event
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpGenderViewController = DependencyContainer.shared.injector.resolve(SignUpGenderViewController.self)
                owner.navigationController?.pushViewController(signUpGenderViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        classTextFieldTapGesture.rx.event
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpClassViewController = DependencyContainer.shared.injector.resolve(SignUpGradeViewController.self)
                owner.navigationController?.pushViewController(signUpClassViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        gradeTextFieldTapGesture.rx.event
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpGradeViewController = DependencyContainer.shared.injector.resolve(SignUpGradeViewController.self)
                owner.navigationController?.pushViewController(signUpGradeViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        schoolTextFieldTapGesture.rx.event
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpSchoolViewController =  DependencyContainer.shared.injector.resolve(SignUpSchoolViewController.self)
                owner.navigationController?.pushViewController(signUpSchoolViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        comfirmInfoBottomSheetView.editButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.hideComfirmInfoBottomSheet()
            }
            .disposed(by: disposeBag)
        
        comfirmInfoBottomSheetView.confirmButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.hideComfirmInfoBottomSheet()
                owner.showPolicyAgreementBottomSheet()
            }
            .disposed(by: disposeBag)
        
        policyAgreementBottomSheetView.confirmButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.reactor?.action.onNext(.createAccount)
            }
            .disposed(by: disposeBag)
        
        policyAgreementBottomSheetView.marketingAgreementButton.isCheckedObservable
            .bind(with: self) { owner, isChecked in
                owner.reactor?.action.onNext(.setMarketingAgreement(isChecked))
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.hideComfirmInfoBottomSheet()
                owner.showPolicyAgreementBottomSheet()
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isAccountCreationCompleted }
            .filter { $0 }
            .bind(with: self) { owner, _ in
                let signUpCompleteViewController = DependencyContainer.shared.injector.resolve(SignUpCompleteViewController.self)
                owner.navigationController?.pushViewController(signUpCompleteViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupBottomSheet() {
        comfirmInfoBottomSheetView.transform = CGAffineTransform(translationX: 0, y: 304)
        policyAgreementBottomSheetView.transform = CGAffineTransform(translationX: 0, y: 412)
    }
    
    private func showComfirmInfoBottomSheet() {
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 1
            self.comfirmInfoBottomSheetView.transform = .identity
        }
    }
    
    private func hideComfirmInfoBottomSheet() {
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 0
            self.comfirmInfoBottomSheetView.transform = CGAffineTransform(translationX: 0, y: 304)
        }
    }
    
    private func showPolicyAgreementBottomSheet() {
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 1
            self.policyAgreementBottomSheetView.transform = .identity
        }
    }
    
    private func hidePolicyAgreementBottomSheet() {
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 0
            self.policyAgreementBottomSheetView.transform = CGAffineTransform(translationX: 0, y: 412)
        }
    }
}
