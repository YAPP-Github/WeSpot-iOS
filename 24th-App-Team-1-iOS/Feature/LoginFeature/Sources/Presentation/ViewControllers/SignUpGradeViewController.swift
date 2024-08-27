//
//  SignUpGradeViewController.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
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

public final class SignUpGradeViewController: BaseViewController<SignUpGradeViewReactor> {
    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Header01, text: "학년")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "회원가입 이후에는 이름을 변경할 수 없어요")
    private let gradeTextField = WSTextField(state: .default)
    private let nextButton = WSButton(wsButtonType: .default(12))
    private let gradeTextFieldtapGesture = UITapGestureRecognizer()
    private let bottomSheetView = SelectGradeBottomSheetView()
    private let dimView = UIView()
    private let dimTapGesture = UITapGestureRecognizer()
    private let accountInjector: Injector = DependencyInjector(container: Container())
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomSheet()
        showBottomSheet()
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(titleLabel, subTitleLabel, gradeTextField, nextButton, dimView, bottomSheetView)
        gradeTextField.addGestureRecognizer(gradeTextFieldtapGesture)
        dimView.addGestureRecognizer(dimTapGesture)
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
        gradeTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(292)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        navigationBar
            .setNavigationBarUI(property: .leftWithCenterItem(DesignSystemAsset.Images.arrow.image, "회원가입"))
            .setNavigationBarAutoLayout(property: .leftWithCenterItem)
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        subTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray400.color
        }
        
        gradeTextField.do {
            $0.text = "현재 학년을 선택해 주세요"
            $0.layer.borderColor = DesignSystemAsset.Colors.primary400.color.cgColor
        }
        
        nextButton.do {
            $0.setupButton(text: "다음")
            $0.isEnabled = false
        }
        
        dimView.do {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        reactor.state
            .map { $0.isGradeSelected }
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.accountRequest.classNumber == 0 ? "다음" : "수정 완료" }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: nextButton.rx.title())
            .disposed(by: disposeBag)
        
        gradeTextFieldtapGesture.rx.event
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.showBottomSheet()
            }
            .disposed(by: disposeBag)
        
        dimTapGesture.rx.event
            .bind(with: self) { owner, _ in
                owner.hideBottomSheet()
            }
            .disposed(by: disposeBag)
        
        bottomSheetView.firstGradeButton.checkButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.showWSToast(image: .warning, message: "만 14세 미만은 가입이 어려워요")
            }
            .disposed(by: disposeBag)
        
        bottomSheetView.secondGradeButton.checkButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let selectedGrade = "2학년"
                owner.gradeTextField.text = selectedGrade
                owner.reactor?.action.onNext(.selectGrade(2))
                owner.hideBottomSheet()
            }
            .disposed(by: disposeBag)
        
        bottomSheetView.thirdGradeButton.checkButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let selectedGrade = "3학년"
                owner.gradeTextField.text = selectedGrade
                owner.reactor?.action.onNext(.selectGrade(3))
                owner.hideBottomSheet()
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .withLatestFrom(reactor.state.map { $0.accountRequest })
            .bind(with: self) { owner, response in
                if response.classNumber == 0 {
                    let signUpClassViewController = DependencyContainer.shared.injector.resolve(SignUpClassViewController.self,  arguments: reactor.currentState.accountRequest, reactor.currentState.schoolName)
                    owner.navigationController?.pushViewController(signUpClassViewController, animated: true)
                } else {
                    owner.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setupBottomSheet() {
        bottomSheetView.transform = CGAffineTransform(translationX: 0, y: 292)
    }
    
    private func showBottomSheet() {
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 1
            self.bottomSheetView.transform = .identity
        }
    }
    
    private func hideBottomSheet() {
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 0
            self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: 292)
        }
    }
}
