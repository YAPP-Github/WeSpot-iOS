//
//  ProfileAccountSettingViewController.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/16/24.
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

public final class ProfileAccountSettingViewController: BaseViewController<ProfileAccountSettingViewReactor> {

    //MARK: - Properties
    private let accountTableView: UITableView = UITableView()
    private let accountDataSources: RxTableViewSectionedReloadDataSource<ProfileAccountSection> = .init { dataSources, tableView, indexPath, sectionItem in
        switch sectionItem {
        case let .accountItem(title):
            guard let accountCell = tableView.dequeueReusableCell(withIdentifier: "ProfileAccountTableViewCell", for: indexPath) as? ProfileAccountTableViewCell else { return UITableViewCell() }
            accountCell.bind(title)
            return accountCell
        }
    }
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubview(accountTableView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        accountTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftWithCenterItem(
                DesignSystemAsset.Images.arrow.image,
                "계정 관리"
            ))
            $0.setNavigationBarAutoLayout(property: .leftWithCenterItem)
        }
        accountTableView.do {
            $0.register(ProfileAccountTableViewCell.self, forCellReuseIdentifier: "ProfileAccountTableViewCell")
            $0.rowHeight = 50
            $0.isScrollEnabled = false
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        reactor.pulse(\.$accountSection)
            .asDriver(onErrorJustReturn: [])
            .drive(accountTableView.rx.items(dataSource: accountDataSources))
            .disposed(by: disposeBag)
        
    }
}
