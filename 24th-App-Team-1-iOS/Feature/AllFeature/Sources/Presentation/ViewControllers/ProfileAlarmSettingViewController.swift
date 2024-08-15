//
//  ProfileAlarmSettingViewController.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
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

public final class ProfileAlarmSettingViewController: BaseViewController<ProfileAlarmSettingViewReactor> {

    //MARK: - Properties
    private let alarmTableView: UITableView = UITableView()
    private let alarmDataSources: RxTableViewSectionedReloadDataSource<ProfileAlarmSection> = .init { dataSources, tableView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .profileAlarmItem(cellReactor):
            guard let alarmInfoCell = tableView.dequeueReusableCell(withIdentifier: "ProfileAlarmTableViewCell", for: indexPath) as? ProfileAlarmTableViewCell else { return UITableViewCell() }
            alarmInfoCell.reactor = cellReactor
            return alarmInfoCell
        }
    }
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubview(alarmTableView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        alarmTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(
                property: .leftWithCenterItem(
                    DesignSystemAsset.Images.arrow.image,
                    "알림 설정"
                )
            )
            $0.setNavigationBarAutoLayout(property: .leftWithCenterItem)
        }
        
        alarmTableView.do {
            $0.register(ProfileAlarmTableViewCell.self, forCellReuseIdentifier: "ProfileAlarmTableViewCell")
            $0.rowHeight = 50
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
        }
        
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        reactor.pulse(\.$profileAlarmSection)
            .asDriver(onErrorJustReturn: [])
            .drive(alarmTableView.rx.items(dataSource: alarmDataSources))
            .disposed(by: disposeBag)
    }
}
