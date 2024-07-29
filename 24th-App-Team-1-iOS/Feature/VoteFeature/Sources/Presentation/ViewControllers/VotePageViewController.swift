//
//  VotePageViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/13/24.
//

import UIKit
import Util
import VoteDomain
import VoteService

import RxSwift
import RxCocoa
import ReactorKit

public final class VotePageViewController: UIPageViewController  {
    //MARK: - Properties
    public typealias Reactor = VotePageViewReactor
    private lazy var voteViewControllers: [UIViewController] = [voteHomeViewController, voteResultViewController]
    private lazy var voteHomeViewController: VoteHomeViewController = DependencyContainer.shared.injector.resolve(VoteHomeViewController.self)
    //TODO: DependecyContaine Result 추가 후 코드 변경
    private lazy var voteResultViewController: VoteResultViewController = VoteResultViewController(reactor: VoteResultViewReactor())
    public var disposeBag: DisposeBag = DisposeBag()
    
    public init(reactor: Reactor) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
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
            setViewControllers([voteHomeViewController], direction: .reverse, animated: true)
        case 1:
            setViewControllers([voteResultViewController], direction: .forward, animated: true)
        default:
            break
        }
    }
}

extension VotePageViewController: ReactorKit.View {
    public func bind(reactor: Reactor) {
        reactor.state
            .map { $0.pageTypes == .main ? 0 : 1 }
            .distinctUntilChanged()
            .bind(with: self) { owner, index in
                owner.setViewController(index: index)
            }
            .disposed(by: disposeBag)
    }
}

extension VotePageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource  {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let beforeIndex = voteViewControllers.firstIndex(of: viewController),
              beforeIndex - 1 >= 0 else { return nil }
        
        return voteViewControllers[beforeIndex - 1]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let afterIndex = voteViewControllers.firstIndex(of: viewController),
              afterIndex + 1 != voteViewControllers.count else { return nil }
        reactor?.action.onNext(.updateViewController(afterIndex))
        return voteViewControllers[afterIndex + 1]
    }
}
