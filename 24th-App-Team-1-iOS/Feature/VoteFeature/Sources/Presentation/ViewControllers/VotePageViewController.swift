//
//  VotePageViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import UIKit
import Util

import RxSwift
import RxCocoa
import ReactorKit

final class VotePageViewController: UIPageViewController  {
    typealias Reactor = VotePageViewReactor
    private lazy var voteViewControllers: [UIViewController] = [voteHomeViewController, voteResultViewController]
    private lazy var voteHomeViewController: VoteHomeViewController = VoteHomeViewController(reactor: VoteHomeViewReactor())
    private lazy var voteResultViewController: VoteResultViewController = VoteResultViewController(reactor: VoteResultViewReactor())
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(reactor: Reactor) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.reactor = reactor
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setupUI()
    }
    
    private func setupUI() {
        setViewController(index: 0)
    }
    
    private func setViewController(index: Int) {
        switch index {
        case 0:
            setViewControllers([voteHomeViewController], direction: .reverse, animated: true)
        case 1:
            setViewControllers([voteResultViewController], direction: .forward, animated: true)
        default:
            break
        }
    }
}

extension VotePageViewController: ReactorKit.View {
    func bind(reactor: Reactor) {
        reactor.state
//            .map { $0.}
    }
    
    
}

extension VotePageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource  {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let beforeIndex = voteViewControllers.firstIndex(of: viewController),
              beforeIndex - 1 >= 0 else { return nil }
        
        return voteViewControllers[beforeIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let afterIndex = voteViewControllers.firstIndex(of: viewController),
              afterIndex + 1 != voteViewControllers.count else { return nil }
        return voteViewControllers[afterIndex + 1]
    }
}
