//
//  VoteCompleteViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/24/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

typealias VoteCompleteStr = VoteStrings
public final class VoteCompleteViewController: BaseViewController<VoteCompleteViewReactor> {

    //MARK: - Properties
    private let onboardingView: VoteCompleteOnBoardingView = VoteCompleteOnBoardingView()
    private let lendingView: VoteCompleteLandingView = VoteCompleteLandingView()
    private let descrptionLabel: WSLabel = WSLabel(wsFont: .Header01, text: VoteCompleteStr.voteCompleteText)
    private let noticeButton: WSButton = WSButton(wsButtonType: .default(12))
    private let shareButton: UIButton = UIButton()
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(shareButton, noticeButton, descrptionLabel, lendingView, onboardingView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        onboardingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lendingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        descrptionLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        noticeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
            $0.left.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        shareButton.snp.makeConstraints {
            $0.left.equalTo(noticeButton.snp.right).offset(15)
            $0.size.equalTo(52)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
        }
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .rightIcon("처음으로"))
            $0.setNavigationBarAutoLayout(property: .rightIcon)
        }
    
        descrptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        shareButton.do {
            $0.configuration = .filled()
            $0.configuration?.baseForegroundColor = DesignSystemAsset.Colors.gray500.color
            $0.configuration?.image = DesignSystemAsset.Images.icShareOutline.image
        }
        
        noticeButton.do {
            $0.setupButton(text: VoteCompleteStr.voteNoticeText)
            $0.setupFont(font: .Body03)
        }
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
                
        lendingView
            .rx.swipeGestureRecognizer(direction: .right)
            .bind(with: self) { owner, _ in
                owner.fadeInOutLendigView()
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .bind(with: self) { owner, _ in
                owner.fadeInOutOnboardingView()
            }
            .disposed(by: disposeBag)
    }
}


extension VoteCompleteViewController {
    private func fadeInOutLendigView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.lendingView.alpha = 0.0
        } completion: { [weak self] _ in
            self?.lendingView.removeFromSuperview()
        }
    }
    
    private func fadeInOutOnboardingView() {
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseInOut) { [weak self] in
            self?.onboardingView.alpha = 0.0
        } completion: { [weak self] _ in
            self?.onboardingView.removeFromSuperview()
        }
    }
}
