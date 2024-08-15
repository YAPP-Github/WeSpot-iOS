//
//  ProfileWebViewController.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/14/24.
//

import DesignSystem
import UIKit
import Util
import WebKit

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class ProfileWebViewController: BaseViewController<ProfileWebViewReactor> {

    //MARK: - Properties
    private let webView: WKWebView = WKWebView()
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .hideTabBar, object: nil)
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(webView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        webView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        reactor.state
            .compactMap { $0.contentURL }
            .distinctUntilChanged()
            .bind(to: webView.rx.loadURL)
            .disposed(by: disposeBag)
    }
}
