//
//  MessageReportViewController.swift
//  MessageFeature
//
//  Created by eunseou on 7/24/24.
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

public final class MessageReportViewController: BaseViewController<MessageReportViewReactor> {
    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Header01, text: "해당 쪽지를 신고하시는 이유가 궁금해요")
    private let notificationImageView = UIImageView(image: .remove)
    private let notificationLabel = WSLabel(wsFont: .Body02, text: "유의사항")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "허위 신고로 확인될 시 서비스 이용이 제한돼요")
    private let detailLabel = WSLabel(wsFont: .Body08, text: "* 쪽지는 신고 즉시 차단됩니다.")
    private lazy var reportInfoTableView = UITableView()
    private let confirmButton = WSButton(wsButtonType: .default(12))
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(titleLabel, notificationImageView, notificationLabel, subTitleLabel, detailLabel, reportInfoTableView, confirmButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        notificationImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.size.equalTo(24)
        }
        
        notificationLabel.snp.makeConstraints {
            $0.leading.equalTo(notificationImageView.snp.trailing).offset(6)
            $0.top.equalTo(notificationImageView)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(notificationImageView.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        reportInfoTableView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-18)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftWithCenterItem(DesignSystemAsset.Images.arrow.image, "신고"))
            $0.setNavigationBarAutoLayout(property: .leftWithCenterItem)
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        notificationImageView.do {
            $0.image = DesignSystemAsset.Images.exclamationmarkFillDestructive.image
        }
        
        notificationLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        subTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        detailLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray300.color
        }
        
        reportInfoTableView.do {
            $0.register(MessageReportTableViewCell.self, forCellReuseIdentifier: MessageReportTableViewCell.identifier)
            $0.rowHeight = 72
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
        
        confirmButton.do {
            $0.setupButton(text: "선택 완료")
            $0.setupFont(font: .Body03)
        }
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        let dataSource = RxTableViewSectionedReloadDataSource<ReportMessageSection>(configureCell: { (dataSource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageReportTableViewCell.identifier, for: indexPath) as! MessageReportTableViewCell
            cell.configureCell(text: item.description, isSelected: item.isSelected)
            cell.selectionStyle = .none
            return cell
        })
        
        reactor.state
            .map { $0.sections }
            .bind(to: reportInfoTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reportInfoTableView.rx.itemSelected
            .map { Reactor.Action.selectReason($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reportInfoTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.reportInfoTableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
}
