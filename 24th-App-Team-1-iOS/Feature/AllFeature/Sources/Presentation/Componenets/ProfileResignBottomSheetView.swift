//
//  ProfileResignBottomSheetView.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import DesignSystem
import UIKit
import Util

import RxSwift
import RxCocoa

public final class ProfileResignBottomSheetView: BaseViewController<ProfileResignBottomSheetVieReactor> {
    private let containerView: UIView = UIView()
    private let titleLabel: WSLabel = WSLabel(wsFont: .Body01)
    private let reasonTextView: UITextView = UITextView()
    private let agreementLabel: WSLabel = WSLabel(wsFont: .Body05)
    private let agreementButton: UIButton = UIButton(type: .custom)
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func setupUI() {
        super.setupUI()
        containerView.addSubviews(titleLabel, reasonTextView, agreementLabel, agreementButton, confirmButton)
        view.addSubview(containerView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(340)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(27)
        }
        
        reasonTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(27)
            $0.height.equalTo(90)
        }
        
        agreementButton.snp.makeConstraints {
            $0.size.equalTo(23)
            $0.left.equalToSuperview().inset(29)
            $0.top.equalTo(reasonTextView.snp.bottom).offset(28)
        }
        
        agreementLabel.snp.makeConstraints {
            $0.height.equalTo(21)
            $0.left.equalTo(agreementButton.snp.right).offset(8)
            $0.centerY.equalTo(agreementButton)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
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
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.backgroundColor = DesignSystemAsset.Colors.gray600.color
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "꼭 확인해 주세요"
            $0.textAlignment = .left
        }
        
        reasonTextView.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.textAlignment = .left
            $0.backgroundColor = .clear
            $0.font = WSFont.Body06.font()
            $0.text = """
                    •탈퇴 시점 기준 15일(360시간)이 지난 후에는 영구적으로 탈퇴 처리되어 복구할 수 없어요\n
                    •탈퇴 후 계정을 복구하고 싶다면 15일(360시간)이 지나기 전에 가입한 계정으로 다시 로그인해 주세요
                    """
        }
        
        agreementLabel.do {
            $0.text = "모든 내용을 숙지하였고, 탈퇴에 동의합니다"
            $0.textAlignment = .left
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        agreementButton.do {
            $0.setBackgroundImage(DesignSystemAsset.Images.checkSelected.image, for: .selected)
            $0.setBackgroundImage(DesignSystemAsset.Images.check.image, for: .normal)
            $0.setTitle("", for: .normal)
        }
        
        
        confirmButton.do {
            $0.setupButton(text: "탈퇴하기")
            $0.setupFont(font: .Body03)
            $0.isEnabled = false
        }
        
        
    }
    
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        agreementButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedAgreementButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isEnabled }
            .distinctUntilChanged()
            .bind(to: agreementButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isEnabled }
            .distinctUntilChanged()
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        confirmButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedResignConfirmButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}
