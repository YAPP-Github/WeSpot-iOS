//
//  WSWebViewController.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/14/24.
//

import UIKit
import WebKit

import SnapKit
import RxCocoa
import ReactorKit

public final class WSWebViewController: UIViewController, ReactorKit.View {
    //MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var navigationBar: WSNavigationBar = WSNavigationBar()
    private let webView: WKWebView = WKWebView()
    
    //MARK: - LifeCycle
    
    public convenience init(reactor: WSWebViewReactor? = nil) {
        self.init()
        self.reactor = reactor
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .hideTabBar, object: nil)
    }
    
    //MARK: - Configure
    public func setupUI() {
        view.addSubviews(navigationBar, webView)
    }
    
    public func setupAutoLayout() {
        navigationBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
        
        webView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    public func setupAttributes() {
        view.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray900.color
        }
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
    }
    
    public func bind(reactor: WSWebViewReactor) {
        reactor.state
            .compactMap { $0.contentURL }
            .distinctUntilChanged()
            .bind(to: webView.rx.loadURL)
            .disposed(by: disposeBag)
        
        navigationBar.leftBarButton
            .rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
