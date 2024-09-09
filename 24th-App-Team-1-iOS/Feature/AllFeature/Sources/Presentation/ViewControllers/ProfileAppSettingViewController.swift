//
//  ProfileAppSettingViewController.swift
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

public final class ProfileAppSettingViewController: BaseViewController<ProfileAppSettingViewReactor> {

    //MARK: - Properties
    private let appSettingTableView: UITableView = UITableView()
    private let appSettingDataSources: RxTableViewSectionedReloadDataSource<ProfileAppSection> = .init { dataSources, tableView, indexPath, sectionItem in
        switch sectionItem {
        case let .alarmItem(title):
            guard let alarmInfoCell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            alarmInfoCell.bind(title)
            alarmInfoCell.selectionStyle = .none
            return alarmInfoCell
        case let .privacyItem(title):
            guard let privacyInfoCell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            privacyInfoCell.bind(title)
            privacyInfoCell.selectionStyle = .none
            return privacyInfoCell
        case let .accountItem(title):
            guard let accountInfoCell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            
            accountInfoCell.bind(title)
            accountInfoCell.selectionStyle = .none
            
            return accountInfoCell
        }
    }
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubview(appSettingTableView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        appSettingTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        appSettingTableView.do {
            $0.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
            $0.register(MainTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "MainTableViewHeaderFooterView")
            $0.rowHeight = 50
            $0.isScrollEnabled = false
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        appSettingTableView
            .rx.itemSelected
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, indexPath in
                switch owner.appSettingDataSources[indexPath] {
                case .alarmItem:
                    let alarmViewController = DependencyContainer.shared.injector.resolve(ProfileAlarmSettingViewController.self)
                    owner.navigationController?.pushViewController(alarmViewController, animated: true)
                case .privacyItem:
                    if indexPath.item == 0 {
                        let profileWebViewController = DependencyContainer.shared.injector.resolve(WSWebViewController.self, argument: WSURLType.privacyTerms.urlString)
                        owner.navigationController?.pushViewController(profileWebViewController, animated: true)
                    } else if indexPath.item == 1 {
                        let profileWebViewController = DependencyContainer.shared.injector.resolve(WSWebViewController.self, argument: WSURLType.serviceTerms.urlString)
                        owner.navigationController?.pushViewController(profileWebViewController, animated: true)
                    } else {
                        // TODO 최신 버전 링크 여쭤보기
                    }
                case .accountItem:
                    if indexPath.item == 0 {
                        let profileUserBlockViewController = DependencyContainer.shared.injector.resolve(ProfileUserBlockViewController.self)
                        owner.navigationController?.pushViewController(profileUserBlockViewController, animated: true)
                    } else {
                        let profileAccountSettingViewController = DependencyContainer.shared.injector.resolve(ProfileAccountSettingViewController.self)
                        owner.navigationController?.pushViewController(profileAccountSettingViewController, animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$profileAppSection)
            .asDriver(onErrorJustReturn: [])
            .drive(appSettingTableView.rx.items(dataSource: appSettingDataSources))
            .disposed(by: disposeBag)
        
        appSettingTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}


extension ProfileAppSettingViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch self.appSettingDataSources[section] {
        case .alarmInfo, .privacyInfo:
            guard let lineView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainTableViewHeaderFooterView") as? MainTableViewHeaderFooterView else { return UITableViewHeaderFooterView() }
            return lineView
        default:
            return nil
        }
    }
    
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
