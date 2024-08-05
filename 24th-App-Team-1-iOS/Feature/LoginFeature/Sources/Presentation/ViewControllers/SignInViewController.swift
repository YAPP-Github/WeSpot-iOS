//
//  SignInViewController.swift
//  LoginFeature
//
//  Created by eunseou on 7/13/24.
//

import UIKit
import Util
import Storage
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import AuthenticationServices

public final class SignInViewController: BaseViewController<SignInViewReactor> {
    
    //MARK: - Properties
    private let onboardingCarouselView = UIScrollView()
    private let pageControl = UIPageControl()
    private let appleLoginButton = ASAuthorizationAppleIDButton()
    private let kakaoLoginButton = UIButton()
    private let onbardingImages: [UIImage] = [.actions,
                                              .checkmark,
                                              .add]
    private let onbardingLabel = WSLabel(wsFont: .Header01, text: "우리가 연결되어 공간\n위스팟에 오신 것을 환영해요")
    private let onbardingLottieView = WSLottieView()
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserDefaultsManager.shared.isAccessed = true
        UserDefaultsManager.shared.accessToken = nil
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(onboardingCarouselView, pageControl, appleLoginButton, kakaoLoginButton, onbardingLabel, onbardingLottieView)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCarousel()
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        onboardingCarouselView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(51)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(450)
        }
        pageControl.snp.makeConstraints {
            $0.top.equalTo(onboardingCarouselView.snp.bottom).offset(16)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        appleLoginButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(pageControl.snp.bottom).offset(64)
            $0.height.equalTo(44)
            $0.width.equalTo(323)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(appleLoginButton.snp.bottom).offset(16)
            $0.height.equalTo(44)
            $0.width.equalTo(323)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        onbardingLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.horizontalEdges.equalTo(30)
        }
        onbardingLottieView.snp.makeConstraints {
            $0.top.equalTo(onbardingLabel.snp.bottom).offset(120)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(250)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        onboardingCarouselView.do {
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.bounces = false
        }
        
        pageControl.do {
            $0.numberOfPages = 3
            $0.currentPage = 0
        }
        
        kakaoLoginButton.do {
            $0.setImage(DesignSystemAsset.Images.kakaoLoginButton.image, for: .normal)
        }
        
        onbardingLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.isHidden = true
        }
        
        onbardingLottieView.do {
            $0.isHidden = true
            $0.isStauts = false
            $0.wsAnimation = DesignSystemAnimationAsset.demo.animation
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        appleLoginButton.rx.loginOnTap()
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { authorization in Reactor.Action.signInWithApple(authorization)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        kakaoLoginButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { SignInViewReactor.Action.signInWithKakao }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        pageControl.rx.controlEvent(.valueChanged)
            .map { _ in self.pageControl.currentPage }
            .bind(with: self) { owner, currentPage in
                let offsetX = CGFloat(currentPage) * owner.onboardingCarouselView.frame.width
                owner.onboardingCarouselView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.signUpTokenResponse != nil }
            .bind(with: self) { owner, state in
                // 메인 스레드에서 UI 업데이트
                DispatchQueue.main.async {
                    owner.updateUI()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    let signUpSchoolViewController = DependencyContainer.shared.injector.resolve(SignUpSchoolViewController.self)
                    signUpSchoolViewController.hidesBottomBarWhenPushed = true
                    owner.navigationController?.pushViewController(signUpSchoolViewController, animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.accountResponse != nil }
            .bind(with: self) { owner, state in
                // 메인 스레드에서 UI 업데이트
                DispatchQueue.main.async {
                    owner.updateUI()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    // 다음 화면으로 이동 처리
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setupCarousel() {
        
        onboardingCarouselView.delegate = self
        
        for i in 0..<onbardingImages.count {
            let imageView = UIImageView()
            let xPos = onboardingCarouselView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: onboardingCarouselView.bounds.width, height: onboardingCarouselView.bounds.height)
            imageView.image = onbardingImages[i]
            onboardingCarouselView.addSubview(imageView)
            onboardingCarouselView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func updateUI() {
        onbardingLabel.isHidden = false
        onbardingLottieView.isHidden = false
        onbardingLottieView.isStauts = true
        onboardingCarouselView.isHidden = true
        appleLoginButton.isHidden = true
        kakaoLoginButton.isHidden = true
        pageControl.isHidden = true
    }
}

extension SignInViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        pageControl.currentPage = Int(round(value))
    }
}
