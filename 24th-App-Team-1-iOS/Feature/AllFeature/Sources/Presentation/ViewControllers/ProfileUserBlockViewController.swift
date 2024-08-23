//
//  ProfileUserBlockViewController.swift
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

public final class ProfileUserBlockViewController: BaseViewController<ProfileUserBlockViewReactor> {

    //MARK: - Properties
    private let blockTableView: UITableView = UITableView()
    private let loadingIndicatorView: WSLottieIndicatorView = WSLottieIndicatorView()
    private let blockDataSources: RxTableViewSectionedReloadDataSource<ProfileUserBlockSection> = .init { dataSources, tableView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .userBlockItem(cellReactor):
            guard let userBlockCell = tableView.dequeueReusableCell(withIdentifier: "ProfileBlockTableViewCell", for: indexPath) as? ProfileBlockTableViewCell else { return UITableViewCell() }
            userBlockCell.selectionStyle = .none
            userBlockCell.reactor = cellReactor
            return userBlockCell
        }
    }
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubview(blockTableView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        blockTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        blockTableView.do {
            $0.register(ProfileBlockTableViewCell.self, forCellReuseIdentifier: "ProfileBlockTableViewCell")
            $0.register(ProfileBlockTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "ProfileBlockTableViewHeaderFooterView")
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
            $0.rowHeight = 90
        }
        
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$userBlockSection)
            .asDriver(onErrorJustReturn: [])
            .drive(blockTableView.rx.items(dataSource: blockDataSources))
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .bind(to: loadingIndicatorView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$userBlockId)
            .filter { !$0.isEmpty }
            .bind(with: self) { owner, _ in
                WSAlertBuilder(showViewController: self)
                    .setAlertType(type: .message)
                    .setTitle(title: "차단 해제하시나요?", titleAlignment: .left)
                    .setConfirm(text: "차단 해제")
                    .setCancel(text: "닫기")
                    .action(.confirm, action: { [weak self] in
                        guard let self else { return }
                        self.reactor?.action.onNext(.didTappedUserBlockButton)
                    })
                    .show()
            }
            .disposed(by: disposeBag)
        blockTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}


extension ProfileUserBlockViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let titleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileBlockTableViewHeaderFooterView") as? ProfileBlockTableViewHeaderFooterView else { return UITableViewHeaderFooterView() }
        return titleView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
