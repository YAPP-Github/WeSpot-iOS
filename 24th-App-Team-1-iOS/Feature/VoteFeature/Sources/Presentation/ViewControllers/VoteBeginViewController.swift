//
//  VoteBeginViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import DesignSystem
import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

fileprivate typealias VoteBeginStr = VoteStrings
public final class VoteBeginViewController: BaseViewController<VoteBeginViewReactor> {

    //MARK: - Properties
    private let beginInfoLabel: WSLabel = WSLabel(wsFont: .Header01, text: VoteBeginStr.voteBeginInfoText)
    private let inviteButton: WSButton = WSButton(wsButtonType: .default(12))
    private let beginlottieView: WSLottieView = WSLottieView()
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(beginInfoLabel, beginlottieView, inviteButton)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .hideTabBar, object: nil)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        beginInfoLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        beginlottieView.snp.makeConstraints {
            $0.top.equalTo(beginInfoLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(450)
        }
        
        inviteButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
            $0.height.equalTo(52)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        beginInfoLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        beginlottieView.do {
            $0.isStauts = true
        }
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        inviteButton.do {
            $0.setupButton(text: VoteBeginStr.voteInviteButtonText)
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
    }
}
