//
//  WSTabBarViewController.swift
//  DesignSystem
//
//  Created by eunseou on 7/17/24.
//

import UIKit
import Extensions

import SnapKit
import RxSwift
import RxCocoa

public final class WSTabBarViewController: UITabBarController {
    
    // MARK: - Properties
    public let tabBarView = WSTabBar()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    deinit {
        NotificationCenter.default.removeObserver(self, name: .hideTabBar, object: nil)
        NotificationCenter.default.removeObserver(self, name: .showTabBar, object: nil)
    }
    
    // MARK: - Functions
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isHidden = true
        
        setupUI()
        setupAttributes()
        setupAutoLayout()
        bind()
        setupNotificationCenter()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        additionalSafeAreaInsets.bottom = tabBarView.isHidden ? 0 : tabBarView.frame.height
        
        updateTabBarButtonState()
    }
    
    // MARK: - Functions
    private func setupUI() {
        
        view.addSubview(tabBarView)
    }
    
    private func setupAttributes() {
        
        view.backgroundColor = .clear
    }
    
    private func setupAutoLayout() {
        
        tabBarView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(98)
        }
    }
    
    private func bind() {
        
        tabBarView.voteButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.selectedIndex = 0
                owner.updateTabBarButtonState()
            }
            .disposed(by: disposeBag)
        
        tabBarView.messageButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.selectedIndex = 1
                owner.updateTabBarButtonState()
            }
            .disposed(by: disposeBag)
        
        tabBarView.allButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.selectedIndex = 2
                owner.updateTabBarButtonState()
            }
            .disposed(by: disposeBag)
        
    }
    
    private func updateTabBarButtonState() {
        
        tabBarView.voteButton.updateState(isSelected: selectedIndex == 0)
        tabBarView.messageButton.updateState(isSelected: selectedIndex == 1)
        tabBarView.allButton.updateState(isSelected: selectedIndex == 2)
    }
    
    public func setTabBar(hidden: Bool) {
        tabBarView.isHidden = hidden
        additionalSafeAreaInsets.bottom = hidden ? 0 : tabBarView.frame.height
        
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(hideTabBar), name: .hideTabBar, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showTabBar), name: .showTabBar, object: nil)
    }
    
    @objc private func hideTabBar() {
        
        setTabBar(hidden: true)
    }
    
    @objc private func showTabBar() {
        
        setTabBar(hidden: false)
    }
}
