//
//  SignUpInfoBottomSheetViewController.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/26/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class SignUpInfoBottomSheetViewController: BaseViewController<SignUpInfoBottomSheetViewReactor> {

    //MARK: - Properties
    private let containerView = UIView()
    private let titleLabel = WSLabel(wsFont: .Body01, text: "해당 정보로 가입하시겠습니까?")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "가입 이후 개인 정보 변경은 1:1 문의로 요청해주세요")
    private let profileImageView = UIImageView()
    private let infoLabel = WSLabel(wsFont: .Header01)
    private let subInfoLabel = WSLabel(wsFont: .Body02)
    public let editButton = WSButton(wsButtonType: .secondaryButton)
    public let confirmButton = WSButton(wsButtonType: .default(10))
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let self else { return }
            self.containerView.transform = .identity
        }, completion: nil)
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        containerView.addSubviews(titleLabel, subTitleLabel, profileImageView, infoLabel, subInfoLabel, editButton, confirmButton)
        view.addSubview(containerView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        containerView.snp.makeConstraints {
            $0.height.equalTo(304)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(35.5)
            $0.leading.equalToSuperview().offset(36)
            $0.size.equalTo(56)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(35.5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        subInfoLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        editButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(39.5)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(39.5)
            $0.leading.equalTo(editButton.snp.trailing).offset(11)
            $0.height.equalTo(52)
            $0.width.equalTo(editButton)
            $0.trailing.equalToSuperview().inset(20)
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
            $0.layer.cornerRadius = 25
            $0.transform = CGAffineTransform(translationX: 0, y: 304)
            $0.layer.masksToBounds = true
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        profileImageView.do {
            $0.image = DesignSystemAsset.Images.icDefaultProfile.image
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        subTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        infoLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        subInfoLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        editButton.do {
            $0.setupButton(text: "수정할래요")
        }
        confirmButton.do {
            $0.setupButton(text: "네 좋아요")
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        Observable
            .zip(
                reactor.state.compactMap { $0.accountRequest },
                reactor.state.compactMap { $0.schoolName }
            )
            .compactMap { "\($1) \($0.grade)학년 \($0.classNumber)반"}
            .bind(to: subInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { "\($0.accountRequest.name) (\($0.accountRequest.gender == "female" ? "여학생"  : "남학생"))" }
            .bind(to: infoLabel.rx.text)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedConfirmButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        editButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedAccountEditButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
