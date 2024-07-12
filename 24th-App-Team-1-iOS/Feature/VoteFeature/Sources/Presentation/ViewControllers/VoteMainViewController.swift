//
//  VoteMainViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/11/24.
//

import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import DesignSystem

public final class VoteMainViewController: BaseViewController<VoteMainViewReactor> {
    
    private let voteBannerView: WSBanner = WSBanner(
        image: DesignSystemAsset.Images.invite.image,
        titleText: "위스팟에 친구 초대하기",
        subText: "다양한 친구들과 더 재밌게 사용해 보세요"
    )
    private let voteContainerView: UIView = UIView()
    private let voteConfrimButton: WSButton = WSButton(wsButtonType: .default(12))
    private let voteDateLabel: WSLabel = WSLabel(wsFont: .Body06, text: Date().toFormatString(with: .MddEEE))
    private let voteDescriptionLabel: WSLabel = WSLabel(wsFont: .Body01, text: "지금 우리 반 투표가 진행 중이에요\n반 친구들에 대해 알려주세요")
    private let voteImageView: UIImageView = UIImageView()
    private let voteToggleView: VoteToggleView = VoteToggleView()
    //TODO: PageViewController 추가
    
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        voteContainerView.addSubviews(voteConfrimButton, voteDateLabel, voteImageView, voteDescriptionLabel)
        view.addSubviews(voteBannerView, voteContainerView, voteToggleView)
    }

    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        voteToggleView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        voteBannerView.snp.makeConstraints {
            $0.top.equalTo(voteToggleView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        
        voteContainerView.snp.makeConstraints {
            $0.top.equalTo(voteBannerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
        voteDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(21)
        }
        
        voteDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(voteDateLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(54)
        }
        
        voteImageView.snp.makeConstraints {
            $0.top.equalTo(voteDescriptionLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        voteConfrimButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-28)
        }
        
    }

    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar
            .setNavigationBarUI(property: .default)
            .setNavigationBarAutoLayout(property: .default)
        
        voteContainerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 18
        }
        
        voteConfrimButton.do {
            $0.setupButton(text: "투표하기")
        }
        
        voteDateLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        voteDescriptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        voteImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = DesignSystemAsset.Images.voteSymbol.image
        }

    }

    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        voteToggleView.mainButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapToggleButton(.main) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        voteToggleView.resultButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapToggleButton(.result) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.voteTypes == .main ? true : false }
            .distinctUntilChanged()
            .bind(to: voteToggleView.rx.isSelected)
            .disposed(by: disposeBag)
    }
}
