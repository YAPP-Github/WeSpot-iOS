//
//  VoteHomeViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import DesignSystem
import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

fileprivate typealias VoteHomeStr = VoteStrings
public final class VoteHomeViewController: BaseViewController<VoteHomeViewReactor> {

    //MARK: - Properties
    private let voteBannerView: WSBanner = WSBanner(
        image: DesignSystemAsset.Images.invite.image,
        titleText: VoteHomeStr.voteBannerMainText,
        subText: VoteHomeStr.voteBannerSubText
    )
    private let voteContainerView: UIView = UIView()
    private let voteConfirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let voteDateLabel: WSLabel = WSLabel(wsFont: .Body06, text: Date().toFormatString(with: .MddEEE))
    private let voteDescriptionLabel: WSLabel = WSLabel(wsFont: .Body01, text: VoteHomeStr.voteDescrptionText)
    private let voteImageView: UIImageView = UIImageView()
    private let voteLottieView: WSLottieView = WSLottieView()
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        voteContainerView.addSubviews(voteDateLabel, voteLottieView, voteConfirmButton,voteDescriptionLabel)
        
        view.addSubviews(voteBannerView, voteContainerView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        voteBannerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
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
        
        voteLottieView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(335)
        }
        
        voteConfirmButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-28)
        }
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        voteContainerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 18
        }
        
        voteConfirmButton.do {
            $0.setupButton(text: VoteHomeStr.voteText)
        }
        
        voteDateLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        voteDescriptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        voteLottieView.do {
            $0.lottieView.animation = DesignSystemAnimationAsset.bgVoteMainAnimate.animation
            $0.isStauts = true
            $0.lottieView.loopMode = .playOnce
        }
        
        voteImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = DesignSystemAsset.Images.imgMainSymbol.image
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        self.rx.viewWillAppear
            .bind(with: self) { owner, _ in
                owner.voteLottieView.toggleAnimation(isStatus: true)
            }
            .disposed(by: disposeBag)
        
        voteConfirmButton
            .rx.tap
            .map { Reactor.Action.didTappedVoteButton }
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        voteBannerView
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.shareToKakaoTalk()
            }
            .disposed(by: disposeBag)
    }
}
