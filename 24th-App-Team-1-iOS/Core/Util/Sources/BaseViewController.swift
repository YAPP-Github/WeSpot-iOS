//
//  BaseViewController.swift
//  Util
//
//  Created by Kim dohyun on 6/12/24.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit


open class BaseViewController<R>: UIViewController, ReactorKit.View where R: Reactor {
    //MARK: Properties
    public typealias Reactor = R
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
    open func setupUI() { }
    
    /// 오토레이아웃 설정을 위한 메서드
    open func setupAutoLayout() { }
    
    /// 뷰의 속성 설정을 위한 메서드
    open func setupAttributes() { }
    
    /// 리엑터와 바인딩을 위한 메서드
    open func bind(reactor: R) { }
}
