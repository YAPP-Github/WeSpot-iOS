//
//  BaseViewController.swift
//  Util
//
//  Created by Kim dohyun on 6/12/24.
//

import UIKit

import DesignSystem
import ReactorKit


open class BaseViewController<R>: UIViewController, ReactorKit.View where R: Reactor {
    //MARK: Properties
    public typealias Reactor = R
    public var navigationBar: WSNavigationBar = WSNavigationBar()
    public var disposeBag: DisposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(reactor: Reactor? = nil) {
        self.init()
        self.reactor = reactor
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    //MARK: Configure
    
    /// 서브 뷰 추가를 위한 메서드
    open func setupUI() {
        view.addSubview(navigationBar)
    }
    
    /// 오토레이아웃 설정을 위한 메서드
    open func setupAutoLayout() {
        navigationBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
    
    /// 뷰의 속성 설정을 위한 메서드
    open func setupAttributes() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
    }
    
    /// 리엑터와 바인딩을 위한 메서드
    open func bind(reactor: R) {
        navigationBar.rx.leftBarButtonItem
            .bind(with: self) { owner, type in
                switch type {
                case .leftIcon:
                    owner.navigationController?.popViewController(animated: true)
                case .leftWithRightItem:
                    owner.navigationController?.popViewController(animated: true)
                case .leftWithCenterItem:
                    owner.navigationController?.popViewController(animated: true)
                case .all:
                    owner.navigationController?.popViewController(animated: true)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
}


