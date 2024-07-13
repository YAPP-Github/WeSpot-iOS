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
    
    private let voteToggleView: VoteToggleView = VoteToggleView()
    //TODO: PageViewController 추가
    private let votePageViewController: VotePageViewController = VotePageViewController(reactor: VotePageViewReactor())
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        addChild(votePageViewController)
        view.addSubviews(voteToggleView, votePageViewController.view)
        votePageViewController.didMove(toParent: self)
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
