//
//  VoteInventoryDetailViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/9/24.
//

import DesignSystem
import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import Kingfisher

public final class VoteInventoryDetailViewController: BaseViewController<VoteInventoryDetailViewReactor> {

    //MARK: - Properties
    private let detailBackgroundImageView: UIImageView = UIImageView()
    private let detailContainerView: UIView = UIView()
    private let detailRankView: VoteRankView = VoteRankView()
    private let detailFaceView: UIImageView = UIImageView()
    private let detailTitleLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let detailDescrptionLabel: WSLabel = WSLabel(wsFont: .Body03)
    private let detailNameLabel: WSLabel = WSLabel(wsFont: .Header04)
    private let detailIntroduceLabel: WSLabel = WSLabel(wsFont: .Body06)
    private let detailLogoImageView: UIImageView = UIImageView()
    private let detailConfirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let detailSharedButton: UIButton = UIButton(type: .custom)
    private let loadingIndicator: WSLottieIndicatorView = WSLottieIndicatorView()
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        detailContainerView.addSubviews(detailRankView, detailTitleLabel, detailFaceView, detailDescrptionLabel, detailNameLabel, detailIntroduceLabel, detailLogoImageView)
        view.addSubviews(detailBackgroundImageView, detailContainerView, detailConfirmButton, detailSharedButton)
        
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        detailBackgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        detailContainerView.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(435)
            $0.center.equalToSuperview()
        }
        
        detailRankView.snp.makeConstraints {
            $0.width.equalTo(102)
            $0.height.equalTo(36)
            $0.top.left.equalToSuperview().offset(24)
        }
        
        detailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(detailRankView.snp.bottom).offset(14)
            $0.left.equalToSuperview().inset(24)
            $0.width.equalTo(233)
        }
        
        detailFaceView.snp.makeConstraints {
            $0.size.equalTo(120)
            $0.top.equalTo(detailTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        detailNameLabel.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.top.equalTo(detailFaceView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        detailIntroduceLabel.snp.makeConstraints {
            $0.top.equalTo(detailNameLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(21)
            $0.centerX.equalToSuperview()
        }
        
        detailLogoImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.width.equalTo(92)
            $0.height.equalTo(35)
            $0.centerX.equalToSuperview()
        }
        
        detailConfirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(52)
            $0.left.equalToSuperview().inset(20)
        }
        
        detailSharedButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.size.equalTo(52)
            $0.left.equalTo(detailConfirmButton.snp.right).offset(15)
            $0.right.equalToSuperview().inset(20)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        detailConfirmButton.do {
            $0.setupFont(font: .Body03)
            $0.setupButton(text: "누가 보냈는지 궁금해요")
            
        }
        
        detailRankView.do {
            $0.rankImageView.image = DesignSystemAsset.Images.icResultCrwonFiled.image
            $0.layer.cornerRadius = 18
            $0.layer.masksToBounds = true
            $0.clipsToBounds = true
            $0.layer.borderColor = DesignSystemAsset.Colors.gray300.color.cgColor
            $0.layer.borderWidth = 1
        }
        
        detailBackgroundImageView.do {
            $0.image = DesignSystemAsset.Images.bgResultGradation.image
            $0.contentMode = .scaleToFill
        }
        
        detailContainerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.white.color.withAlphaComponent(0.15)
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
        }
        
        detailTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .left
        }
        
        detailFaceView.do {
            $0.image = DesignSystemAsset.Images.imgResultCharacter.image
        }
        
        detailDescrptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        detailNameLabel.do {
            $0.textColor = DesignSystemAsset.Colors.primary300.color
            $0.textAlignment = .center
        }
        
        detailIntroduceLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.textAlignment = .center
        }
        
        detailSharedButton.do {
            $0.configuration = .filled()
            $0.layer.cornerRadius = 11
            $0.clipsToBounds = true
            $0.configuration?.baseBackgroundColor = DesignSystemAsset.Colors.gray500.color
            $0.configuration?.image = DesignSystemAsset.Images.icCompleteShareOutline.image
        }
        
        detailLogoImageView.do {
            $0.image = DesignSystemAsset.Images.imgInventoryDetailFiled.image
        }
        

    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        detailConfirmButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let paymentWebViewController = DependencyContainer.shared.injector.resolve(WSWebViewController.self, argument: WSURLType.payment.urlString)
                owner.navigationController?.pushViewController(paymentWebViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        detailSharedButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.shareToInstagramStory(to: owner.view)
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .bind(to: loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.receiveEntity }
            .map { "\($0.response.voteCount)표" }
            .bind(to: detailRankView.rankLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.receiveEntity?.response.user }
            .map { $0.profile.iconUrl }
            .bind(with: self) { owner, iconURL in
                owner.detailFaceView.kf.setImage(with: iconURL)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.receiveEntity }
            .map { $0.response.voteOption.content }
            .bind(to: detailTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.receiveEntity }
            .map { $0.response.user.name}
            .bind(to: detailNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.receiveEntity }
            .map { $0.response.user.introduction }
            .bind(to: detailIntroduceLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
