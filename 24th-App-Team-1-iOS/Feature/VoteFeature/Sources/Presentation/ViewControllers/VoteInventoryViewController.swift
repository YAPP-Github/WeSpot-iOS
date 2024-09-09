//
//  VoteInventoryViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 8/7/24.
//

import DesignSystem
import UIKit
import Util
import Extensions

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import RxDataSources


fileprivate typealias VoteInventoryStr = VoteStrings
fileprivate typealias VoteInventoryId = VoteStrings.Identifier
public final class VoteInventoryViewController: BaseViewController<VoteInventoryViewReactor> {

    //MARK: - Properties
    private let toggleView: VoteInventoryToggleView = VoteInventoryToggleView()
    private let inventoryContainerView: UIView = UIView()
    private let inventoryTableView: UITableView = UITableView(frame: .zero, style: .grouped)
    private let loadingIndicator: WSLottieIndicatorView = WSLottieIndicatorView()
    private let inventoryConfirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let inventoryImageView: UIImageView = UIImageView()
    private let inventoryTitleLabel: WSLabel = WSLabel(wsFont: .Body01)
    private let inventorySubTitleLabel: WSLabel = WSLabel(wsFont: .Body05)
    private let inventoryTableViewDataSources: RxTableViewSectionedReloadDataSource<VoteInventorySection> = .init { dataSources, tableView, indexPath, sectionItem in
        switch sectionItem {
        case let .voteReceiveItem(cellReactor):
            guard let receiveCell = tableView.dequeueReusableCell(withIdentifier: VoteInventoryId.voteReceiveCell, for: indexPath) as? VoteReceiveTableViewCell else { return UITableViewCell() }
            receiveCell.reactor = cellReactor
            receiveCell.selectionStyle = .none
            return receiveCell
        case let .voteSentItem(cellReactor):
            
            guard let sentCell = tableView.dequeueReusableCell(withIdentifier: VoteInventoryId.voteSentCell, for: indexPath) as? VoteSentTableViewCell else { return UITableViewCell() }
            sentCell.reactor = cellReactor
            sentCell.selectionStyle = .none
            return sentCell
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
        inventoryContainerView.addSubviews(inventoryImageView, inventoryTitleLabel, inventorySubTitleLabel)
        view.addSubviews(toggleView, inventoryTableView, loadingIndicator ,inventoryContainerView, inventoryConfirmButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        toggleView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(37)
        }
        
        inventoryTableView.snp.makeConstraints {
            $0.top.equalTo(toggleView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        inventoryContainerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(375)
            $0.center.equalToSuperview()
        }
        
        inventoryImageView.snp.makeConstraints {
            $0.width.equalTo(79)
            $0.height.equalTo(77)
            $0.center.equalToSuperview()
        }
        
        inventoryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(inventoryImageView.snp.bottom).offset(24)
            $0.height.equalTo(24)
            $0.centerX.equalToSuperview()
        }
        
        inventorySubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(inventoryTitleLabel.snp.bottom).offset(4)
            $0.height.equalTo(21)
            $0.centerX.equalToSuperview()
        }
        
        inventoryConfirmButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        inventoryTableView.do {
            $0.register(VoteReceiveTableViewCell.self, forCellReuseIdentifier: VoteInventoryId.voteReceiveCell)
            $0.register(VoteSentTableViewCell.self, forCellReuseIdentifier: VoteInventoryId.voteSentCell)
            $0.register(VoteInventoryHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: VoteInventoryId.voteInventoryHeaderCell)
            $0.separatorStyle = .none
            $0.rowHeight = 96
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
        }
        
        inventoryContainerView.do {
            $0.backgroundColor = .clear
            $0.isHidden = true
        }
        
        inventoryConfirmButton.do {
            $0.setupButton(text: "친구 초대하기")
            $0.setupFont(font: .Body03)
            $0.isHidden = true
        }
        
        inventoryImageView.do {
            $0.image = DesignSystemAsset.Images.imgEmptyVoteFiled.image
            $0.contentMode = .scaleAspectFill
        }
        
        inventoryTitleLabel.do {
            $0.text = "아직 받은 투표가 없어요"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        inventorySubTitleLabel.do {
            $0.text = "친구들이 초대하면 투표를 확률이 올라가요"
            $0.textColor = DesignSystemAsset.Colors.gray500.color
        }
        
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        
        Observable.just(())
            .map { Reactor.Action.fetchReceiveItems }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .bind(to: loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        toggleView.receiveButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.fetchReceiveItems }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        toggleView.sentButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.fetchSentItems }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        inventoryTableView.rx
            .itemSelected
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .compactMap { ($0.row, $0.section) }
            .map { Reactor.Action.didTappedItems($0, $1)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        inventoryTableView.rx
            .prefetchRows
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { _ in Reactor.Action.fetchMoreItems }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        inventoryTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
       
        reactor.pulse(\.$voteId)
            .filter { $0 != nil }
            .bind(with: self) { owner, voteId in
                guard let voteId else { return }
                let voteInventoryDetailViewController = DependencyContainer.shared.injector.resolve(VoteInventoryDetailViewController.self, argument: voteId)
                owner.navigationController?.pushViewController(voteInventoryDetailViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$inventorySection)
            .asDriver(onErrorJustReturn: [])
            .drive(inventoryTableView.rx.items(dataSource: inventoryTableViewDataSources))
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.inventoryType }
            .distinctUntilChanged()
            .bind(to: toggleView.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.inventoryType == .sent }
            .withLatestFrom(reactor.state.map { $0.isEmpty })
            .filter { $0 == false }
            .map { _ in "반 친구들에 대해 알려주세요"}
            .bind(to: inventorySubTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.inventoryType == .sent }
            .withLatestFrom(reactor.state.map { $0.isEmpty})
            .filter { $0 == false }
            .map { _ in "아직 보낸 투표가 없어요"}
            .bind(to: inventoryTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.inventoryType == .receive }
            .withLatestFrom(reactor.state.map { $0.isEmpty})
            .filter { $0 == false }
            .map { _ in "아직 받은 투표가 없어요"}
            .bind(to: inventoryTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.inventoryType == .receive }
            .withLatestFrom(reactor.state.map { $0.isEmpty})
            .filter { $0 == false }
            .map { _ in "친구들을 초대하면 투표를 받을 확률이 높아져요"}
            .bind(to: inventorySubTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isEmpty }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind(onNext: {$0.0.setupEmptyLayout(isEmpty: $0.1)})
            .disposed(by: disposeBag)
    }
}


extension VoteInventoryViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let titleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: VoteInventoryId.voteInventoryHeaderCell) as? VoteInventoryHeaderFooterView else { return UITableViewHeaderFooterView() }
        switch inventoryTableViewDataSources[section] {
        case .voteReceiveInfo:
            guard let dateToString = self.reactor?.currentState.receiveEntity?.response[section].date.toDate(with: .dashYyyyMMdd).toFormatRelative() else { return UITableViewHeaderFooterView() }
            titleView.bind(text: dateToString)
            return titleView
        case .voteSentInfo:
            guard let dateSentString = self.reactor?.currentState.sentEntity?.response[section].date.toDate(with: .dashYyyyMMdd).toFormatRelative() else { return UITableViewHeaderFooterView() }
            titleView.bind(text: dateSentString)
            return titleView
        }
    }
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension VoteInventoryViewController {
    private func setupEmptyLayout(isEmpty: Bool) {
        inventoryContainerView.isHidden = isEmpty
        inventoryConfirmButton.isHidden = isEmpty
        inventoryConfirmButton.isEnabled = !isEmpty
        inventoryTableView.isHidden = !isEmpty
    }
}
