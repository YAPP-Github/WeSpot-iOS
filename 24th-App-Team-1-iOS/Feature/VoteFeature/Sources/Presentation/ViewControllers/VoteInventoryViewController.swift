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
import RxDataSources

public final class VoteInventoryViewController: BaseViewController<VoteInventoryViewReactor> {

    //MARK: - Properties
    private let toggleView: VoteInventoryToggleView = VoteInventoryToggleView()
    private let inventoryTableView: UITableView = UITableView()
    private let inventoryTableViewDataSources: RxTableViewSectionedReloadDataSource<VoteInventorySection> = .init { dataSources, tableView, indexPath, sectionItem in
        switch sectionItem {
        case .voteReceiveItem:
                        
            return UITableViewCell()
        case let .voteSentItem(cellReactor):
            
            guard let sentCell = tableView.dequeueReusableCell(withIdentifier: "VoteSentTableViewCell", for: indexPath) as? VoteSentTableViewCell else { return UITableViewCell() }
            return sentCell
        }
    }
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(toggleView, inventoryTableView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        toggleView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(37)
        }
        
        inventoryTableView.snp.makeConstraints {
            $0.top.equalTo(toggleView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        inventoryTableView.do {
            $0.register(VoteSentTableViewCell.self, forCellReuseIdentifier: "VoteSentTableViewCell")
            $0.rowHeight = 80
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
        }
        
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.fetchReceiveItems }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        
        
    }
}
