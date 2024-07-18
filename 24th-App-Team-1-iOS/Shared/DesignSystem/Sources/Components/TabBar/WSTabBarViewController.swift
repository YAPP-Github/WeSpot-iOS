//
//  WSTabBarViewController.swift
//  DesignSystem
//
//  Created by eunseou on 7/17/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

public final class WSTabBarViewController: UIViewController {
    
    // MARK: - Properties
    private let tabBarView = WSTabBar()
    private let viewControllers: [UIViewController]
    private var selectedIndex: Int = 0 {
        didSet { self.updateView() }
    }
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupAttributes()
        setupAutoLayout()
        bind()
        updateView()
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
            }
            .disposed(by: disposeBag)
        
        tabBarView.messageButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.selectedIndex = 1
            }
            .disposed(by: disposeBag)
        
        tabBarView.allButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.selectedIndex = 2
            }
            .disposed(by: disposeBag)
    }
    
    private func updateView() {
        
        deleteView()
        setupView()
        updateButtonStates()
    }
    
    private func deleteView() {
        
        let previousVC = viewControllers[selectedIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
    }
    
    private func setupView() {
        
        let selectedVC = viewControllers[selectedIndex]
        
        self.addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        selectedVC.view.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalTo(tabBarView.snp.top)
        }
        selectedVC.didMove(toParent: self)
    }
    
    private func updateButtonStates() {
        
        tabBarView.voteButton.updateState(isSelected: selectedIndex == 0)
        tabBarView.messageButton.updateState(isSelected: selectedIndex == 1)
        tabBarView.allButton.updateState(isSelected: selectedIndex == 2)
    }
    
}
