//
//  PolicyAgreementBottomSheetViewController.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/26/24.
//

import UIKit
import Util
import DesignSystem

import ReactorKit


public final class PolicyAgreementBottomSheetViewController: BaseViewController<PolicyAgreementBottomSheetViewReactor> {
    private let containerView = UIView()
    private let titleLabel = WSLabel(wsFont: .Body01, text: "서비스 사용을 위한\n약관에 동의해 주세요")
    public let confirmButton = WSButton(wsButtonType: .default(12)).then {
        $0.setupButton(text: "동의하고 시작하기")
        $0.isEnabled = false
    }
    private let subView = UIView()
    private let allAggreementButton = SelectPolicyAgreementView(text: "전체 동의하기", font: .Body04, isHiddenDetailButton: true)
    private let serviceAgreementButton = SelectPolicyAgreementView(text: "(필수) 서비스 이용약관")
    private let privacyAgreementButton = SelectPolicyAgreementView(text: "(필수) 개인정보 수집 및 이용 안내")
    public let marketingAgreementButton = SelectPolicyAgreementView(text: "(선택) 이벤트 및 마케팇 수신 동의")
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func setupUI() {
        super.setupUI()
        containerView.addSubviews(titleLabel, subView, allAggreementButton, serviceAgreementButton, privacyAgreementButton, marketingAgreementButton, confirmButton)
        view.addSubview(containerView)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let self else { return }
            self.containerView.transform = .identity
        }, completion: nil)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        containerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(412)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        subView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.height.equalTo(60)
        }
        allAggreementButton.snp.makeConstraints {
            $0.leading.equalTo(subView).offset(15)
            $0.centerY.equalTo(subView)
        }
        serviceAgreementButton.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(36)
        }
        privacyAgreementButton.snp.makeConstraints {
            $0.top.equalTo(serviceAgreementButton.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(36)
        }
        marketingAgreementButton.snp.makeConstraints {
            $0.top.equalTo(privacyAgreementButton.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(36)
        }
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(marketingAgreementButton.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(44)
        }
        
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.isHidden = true
        }
        
        view.do {
            $0.backgroundColor = .black.withAlphaComponent(0.6)
        }
        
        containerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray600.color
            $0.transform = CGAffineTransform(translationX: 0, y: 412)
            $0.layer.cornerRadius = 25
            $0.layer.masksToBounds = true
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        subView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.layer.cornerRadius = 12
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
    }
    
    public override func bind(reactor: PolicyAgreementBottomSheetViewReactor) {
        
        subView
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedAllAgreement }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        privacyAgreementButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedPrivacyAgreement}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        serviceAgreementButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedServiceAgreement}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        marketingAgreementButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedMarketingAgreement}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isAllAgreement }
            .distinctUntilChanged()
            .bind(with: self) { owner, isChecked in
                owner.allAggreementButton.isChecked = isChecked
                owner.serviceAgreementButton.isChecked = isChecked
                owner.privacyAgreementButton.isChecked = isChecked
                owner.marketingAgreementButton.isChecked = isChecked
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isPrivacyAgreement }
            .distinctUntilChanged()
            .bind(with: self) { owner, isChecked in
                owner.privacyAgreementButton.isChecked = isChecked
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isServiceAgreement }
            .distinctUntilChanged()
            .bind(with: self) { owner, isChecked in
                owner.serviceAgreementButton.isChecked = isChecked
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isMarketingAgreement }
            .distinctUntilChanged()
            .bind(with: self) { owner, isChecked in
                owner.marketingAgreementButton.isChecked = isChecked
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isEnabled }
            .distinctUntilChanged()
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
