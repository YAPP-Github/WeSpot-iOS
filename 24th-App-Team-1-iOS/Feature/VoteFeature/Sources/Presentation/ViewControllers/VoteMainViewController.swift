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
            
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
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
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
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
            .withLatestFrom(reactor.pulse(\.$voteClassMateEntity).compactMap { $0?.user.isEmpty})
            .bind(with: self) { owner, isCheck in
                if isCheck {
                    let voteBegingViewController = DependencyContainer.shared.injector.resolve(VoteBeginViewController.self)
                    owner.navigationController?.pushViewController(voteBegingViewController, animated: true)
                    
                } else {
                    let voteProcessViewController = DependencyContainer.shared.injector.resolve(VoteProcessViewController.self)
                    owner.navigationController?.pushViewController(voteProcessViewController, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
