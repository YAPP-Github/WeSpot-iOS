//
//  WKWebView+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 8/14/24.
//

import UIKit
import WebKit

import RxSwift
import RxCocoa

extension Reactive where Base: WKWebView {
    public var loadURL: Binder<URL> {
        return Binder(self.base) { webView, url in
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
    }
}
