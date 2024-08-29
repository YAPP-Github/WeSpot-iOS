//
//  SignUpCompleteViewController.swift
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

public final class SignUpCompleteViewController: BaseViewController<SignUpCompleteViewReactor> {

    //MARK: - Properties
    private let imageView = UIImageView()
    private let inviteStartButton = WSButton(wsButtonType: .default(12))
    private let completeTitleLabel = WSLabel(wsFont: .Body03)
    private let completeDescriptionLabel = WSLabel(wsFont: .Body02)
    private let startButton = WSButton(wsButtonType: .strokeButton)
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(imageView, inviteStartButton, startButton, completeTitleLabel, completeDescriptionLabel)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(180)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(143)
            $0.height.equalTo(89)
        }
        completeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(25)
            $0.centerX.equalTo(imageView)
            $0.height.equalTo(24)
        }
        completeDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(completeTitleLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(completeTitleLabel)
            $0.height.equalTo(54)
        }
        inviteStartButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(startButton.snp.top).offset(-16)
        }
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        imageView.do {
            $0.image = DesignSystemAsset.Images.imgLoginFriendFiled.image
        }
        
        inviteStartButton.do {
            $0.setupButton(text: "친구 초대하고 시작하기")
        }
        
        startButton.do {
            $0.setupButton(text: "바로 시작하기")
        }
        completeTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.primary300.color
            $0.text = "가입 완료!"
            $0.textAlignment = .center
        }
        completeDescriptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "이제 모든 준비가 끝났어요\n위스팟을 시작해볼까요?"
            $0.textAlignment = .center
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        inviteStartButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.shareToKakaoTalk()
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isExpired)
            .filter { $0 == true }
            .bind(with: self) { owner, _ in
                NotificationCenter.default.post(name: .showSignInViewController, object: nil)
            }
            .disposed(by: disposeBag)
        
        startButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind { _ in
                NotificationCenter.default.post(name: .showVoteMainViewController, object: nil)
            }
            .disposed(by: disposeBag)
    }
}
