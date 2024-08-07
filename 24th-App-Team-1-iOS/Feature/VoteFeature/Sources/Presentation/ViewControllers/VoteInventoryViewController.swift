//
//  VoteInventoryViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/7/24.
//

import DesignSystem
import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class VoteInventoryViewController: BaseViewController<VoteInventoryViewReactor> {

    //MARK: - Properties
    private let toggleView: VoteInventoryToggleView = VoteInventoryToggleView()
    private let inventoryTableView: UITableView = UITableView()
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(toggleView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        toggleView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(37)
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
        
    }
}
