//
//  MessageMainViewController.swift
//  MessageFeature
//
//  Created by eunseou on 7/21/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class MessageMainViewController: BaseViewController<MessageMainViewReactor> {

    //MARK: - Properties
    private let messagePageViewController = MessagePageViewController(reactor: MessagePageViewReactor())
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        addChild(messagePageViewController)
        view.addSubviews(messagePageViewController.view)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        messagePageViewController.view.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .default)
            $0.setNavigationBarAutoLayout(property: .default)
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .filter { $0 == true }
            .bind(with: self) { owner, _ in

            }
            .disposed(by: disposeBag)
    }
}
