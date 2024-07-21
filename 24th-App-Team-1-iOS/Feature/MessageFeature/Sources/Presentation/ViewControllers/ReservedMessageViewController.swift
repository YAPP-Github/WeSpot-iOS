//
//  ReservedMessageViewController.swift
//  MessageFeature
//
//  Created by eunseou on 7/20/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit

public final class ReservedMessageViewController: BaseViewController<ReservedMessageViewReactor> {

    //MARK: - Properties
    private let headerContainerView = UIView()
    private let headerLabel = WSLabel(wsFont: .Header01, text: "예약 중인 쪽지")
    private let reservedMessageTableView = UITableView()

    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(headerContainerView, reservedMessageTableView)
        headerContainerView.addSubview(headerLabel)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        headerContainerView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.height.equalTo(45)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
        }
        reservedMessageTableView.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        navigationBar.do{
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        headerContainerView.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        headerLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        reservedMessageTableView.do {
            $0.register(ReservedMessageTableViewCell.self, forCellReuseIdentifier: ReservedMessageTableViewCell.identifier)
            $0.rowHeight = 90
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        let dataSource = RxTableViewSectionedReloadDataSource<ReservedMessageSection>(configureCell: { (dataSource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: ReservedMessageTableViewCell.identifier, for: indexPath) as! ReservedMessageTableViewCell
            cell.configureCell(image: item.profile ?? DesignSystemAsset.Images.boy.image, text: item.reciptent)
            cell.selectionStyle = .none
            return cell
        })
        
        Observable.just(())
            .map { Reactor.Action.fetchMessages }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$messageSection)
            .bind(to: reservedMessageTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
}
