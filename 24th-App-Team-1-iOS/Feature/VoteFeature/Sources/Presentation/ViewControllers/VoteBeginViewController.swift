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

public final class VoteBeginViewController: BaseViewController<VoteBeginViewReactor> {

    //MARK: - Properties
    private let beginInfoLabel: WSLabel = WSLabel(wsFont: .Header01, text: "투표할 수 있는\n1학년 6반 친구들이 부족해요")
    private let beginButton: WSButton = WSButton(wsButtonType: .default(12))
    private let beginlottieView: WSLottieView = WSLottieView()
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(beginInfoLabel, beginlottieView, beginButton)
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
        
        beginButton.snp.makeConstraints {
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
            $0.wsAnimation = DesignSystemAnimationAsset.demo.animation
        }
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        beginButton.do {
            $0.setupButton(text: "친구 초대하기")
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
    }
}
