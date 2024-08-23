//
//  ProfileResignViewController.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
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


public final class ProfileResignViewController: BaseViewController<ProfileResignViewReactor> {

    //MARK: - Properties
    private let resignReasonLabel: WSLabel = WSLabel(wsFont: .Header01)
    private let resignTableView: UITableView = UITableView()
    private let loadingIndicatorView: WSLottieIndicatorView = WSLottieIndicatorView()
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let resignDataSources: RxTableViewSectionedReloadDataSource<ProfileResignReasonSection> = .init { dataSources, tableView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .resignReasonItem(cellReactor):
            guard let reasonCell = tableView.dequeueReusableCell(withIdentifier: "ProfileResignTableViewCell", for: indexPath) as? ProfileResignTableViewCell else { return UITableViewCell() }
            reasonCell.selectionStyle = .none
            reasonCell.reactor = cellReactor
            return reasonCell
        }
    }
    
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
        view.addSubviews(resignReasonLabel, resignTableView, confirmButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        resignReasonLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(30)
        }
        
        resignTableView.snp.makeConstraints {
            $0.top.equalTo(resignReasonLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(364)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftWithCenterItem(
                DesignSystemAsset.Images.arrow.image,
                "회원 탈퇴"
            ))
            $0.setNavigationBarAutoLayout(property: .leftWithCenterItem)
        }
        
        resignReasonLabel.do {
            $0.text = "탈퇴하시는 이유가 궁금해요"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .left
        }
        
        resignTableView.do {
            $0.register(ProfileResignTableViewCell.self, forCellReuseIdentifier: "ProfileResignTableViewCell")
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.allowsMultipleSelection = true
            $0.rowHeight = 72
        }
        
        confirmButton.do {
            $0.setupFont(font: .Body03)
            $0.setupButton(text: "선택 완료")
            $0.isEnabled = false
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        reactor.pulse(\.$reasonSection)
            .asDriver(onErrorJustReturn: [])
            .drive(resignTableView.rx.items(dataSource: resignDataSources))
            .disposed(by: disposeBag)
        
        resignTableView
            .rx.itemDeselected
            .map { Reactor.Action.didTappedDeselectedItems($0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        resignTableView
            .rx.itemSelected
            .map { Reactor.Action.didTappedReasonItems($0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        confirmButton
            .rx.tap
            .bind(with: self) { owner, _ in
                let agreementBottomSheetView = DependencyContainer.shared.injector.resolve(ProfileResignBottomSheetView.self)
                agreementBottomSheetView.modalPresentationStyle = .overCurrentContext
                agreementBottomSheetView.modalTransitionStyle = .crossDissolve
                owner.present(agreementBottomSheetView, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        reactor.pulse(\.$isSuccess)
            .filter { $0 == true}
            .bind(with: self) { owner, _ in
                NotificationCenter.default.post(name: .showSignInViewController, object: nil)
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isStatus)
            .filter { $0 == true }
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true) {
                    WSAlertBuilder(showViewController: owner)
                        .setAlertType(type: .message)
                        .setTitle(title: "정말 탈퇴하시나요", titleAlignment: .left)
                        .setCancel(text: "탈퇴")
                        .setConfirm(text: "닫기")
                        .action(.cancel) { [weak self] in
                            guard let self else { return }
                            self.reactor?.action.onNext(.didTappedResignButton)
                        }
                        .show()
                }
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .bind(to: loadingIndicatorView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isEnabled)
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
