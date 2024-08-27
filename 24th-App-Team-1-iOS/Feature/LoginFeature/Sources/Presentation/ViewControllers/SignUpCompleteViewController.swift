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
    private let startButton = WSButton(wsButtonType: .strokeButton)
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(imageView, inviteStartButton, startButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(51)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(450)
        }
        inviteStartButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(103)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
        }
        startButton.snp.makeConstraints {
            $0.top.equalTo(inviteStartButton.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        imageView.do {
            $0.image = DesignSystemAsset.Images.imgLoginFriendFiled.image
        }
        
        inviteStartButton.do {
            $0.setupButton(text: "친구 초대하고 시작하기")
        }
        
        startButton.do {
            $0.setupButton(text: "바로 시작하기")
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
    }
}
