//
//  MessagePageViewController.swift
//  MessageFeature
//
//  Created by eunseou on 7/21/24.
//

import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

final class MessagePageViewController: UIPageViewController, View {

    //MARK: - Properties
    typealias Reactor = MessagePageViewReactor
    private lazy var messageViewControllers: [UIViewController] = [messageHomeViewController, messageStorageViewController]
    private lazy var messageHomeViewController = MessageHomeViewController(reactor: MessageHomeViewReactor())
    private lazy var messageStorageViewController = MessageStorageViewController(reactor: MessageStorageViewReactor())
    var disposeBag: DisposeBag = DisposeBag()
    
    //MARK: - Initialize
    init(reactor: Reactor) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupUI()
        setupAttributes()
    }

    //MARK: - Configure
    private func setupUI() {
        
        setViewController(index: 0)
    }
    
    private func setupAttributes() {
        
        delegate = self
        dataSource = self
        isPagingEnabled = false
    }
    
    private func setViewController(index: Int) {
        
        switch index {
        case 0:
            setViewControllers([messageHomeViewController], direction: .reverse, animated: true)
        case 1:
            setViewControllers([messageStorageViewController], direction: .forward, animated: true)
        default:
            break
        }
    }
    
    func bind(reactor: Reactor) {
        
        reactor.state
            .map { $0.pageTypes == .home ? 0 : 1 }
            .distinctUntilChanged()
            .bind(with: self) { owner, index in
                owner.setViewController(index: index)
            }
            .disposed(by: disposeBag)
    }
}

extension MessagePageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource  {
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = messageViewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return messageViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = messageViewControllers.firstIndex(of: viewController), index < messageViewControllers.count - 1 else {
            return nil
        }
        reactor?.action.onNext(.updateViewController(index + 1))
        return messageViewControllers[index + 1]
    }
}
