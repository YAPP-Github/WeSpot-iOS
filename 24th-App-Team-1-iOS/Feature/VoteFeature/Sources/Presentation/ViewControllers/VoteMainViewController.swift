//
//  VoteMainViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/11/24.
//

import UIKit
import Util
import Storage

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import DesignSystem

public final class VoteMainViewController: BaseViewController<VoteMainViewReactor> {
    
    //MARK: - Properties
    private let voteToggleView: VoteToggleView = VoteToggleView()
    private lazy var votePageViewController: VotePageViewController = VotePageViewController(reactor: VotePageViewReactor())
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .showTabBar, object: nil)
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        addChild(votePageViewController)
        view.addSubviews(voteToggleView, votePageViewController.view)
    }

    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        voteToggleView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        votePageViewController.view.snp.makeConstraints {
            $0.top.equalTo(voteToggleView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
    }

    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar
            .setNavigationBarUI(property: .default)
            .setNavigationBarAutoLayout(property: .default)
    }

    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        reactor.pulse(\.$isProfileUpdate)
            .filter { $0 == true }
            .bind(with: self) { owner, _ in
                owner.showWSToast(image: .check, message: "프로필 설정 완료")
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isProfileChanged }
            .filter { $0 == false }
            .take(1)
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, _ in
                WSAlertBuilder(showViewController: owner)
                     .setAlertType(type: .titleWithMeesage)
                     .setTitle(title: "프로필 설정을 해볼까요", titleAlignment: .left)
                     .setMessage(message: "친구들이 알아볼 수 있도록\n캐릭터 선택과 한 줄 소개 작성을 완료해 주세요")
                     .setCancel(text: "다음에 할게요")
                     .setConfirm(text: "네 좋아요")
                     .action(.confirm) {
                         NotificationCenter.default.post(name: .showProfileImageViewController, object: nil)
                     }
                     .show()
            }
            .disposed(by: disposeBag)
        
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
        
        navigationBar.rightBarButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                NotificationCenter.default.post(name: .showNotifcationViewController, object: nil)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.voteTypes == .main ? true : false }
            .distinctUntilChanged()
            .skip(1)
            .bind(to: voteToggleView.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isShowEffectView)
            .filter { $0 == true }
            .bind(with: self) { owner, _ in
                let voteEffectViewController = DependencyContainer.shared.injector.resolve(VoteEffectViewController.self)
                owner.navigationController?.pushViewController(voteEffectViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        reactor.pulse(\.$isSelected)
            .filter { $0 == true }
            .bind(with: self) { owner, _ in
                let voteProcessViewController = DependencyContainer.shared.injector.resolve(VoteProcessViewController.self)
                owner.navigationController?.pushViewController(voteProcessViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
