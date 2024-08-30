//
//  VoteProcessViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import DesignSystem
import Extensions
import UIKit
import Util

import Then
import SnapKit
import Swinject
import RxSwift
import RxCocoa
import ReactorKit
import RxDataSources
import Kingfisher

fileprivate typealias VoteProcessStr = VoteStrings
fileprivate typealias VoteProcessId = VoteStrings.Identifier
public final class VoteProcessViewController: BaseViewController<VoteProcessViewReactor> {

    //MARK: - Properties
    private let profileView: UIView = UIView()
    private let faceImageView: UIImageView = UIImageView()
    private let questionLabel: WSLabel = WSLabel(wsFont: .Header01)
    private let loadingIndicator: WSLottieIndicatorView = WSLottieIndicatorView()
    private let questionTableView: UITableView = UITableView()
    private let resultButton: WSButton = WSButton(wsButtonType: .default(12))
    private let voteBeginView: VoteBeginView = VoteBeginView()
    private let questionDataSources: RxTableViewSectionedReloadDataSource<VoteProcessSection> = .init { dataSources, tableView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .voteQuestionItem(cellReactor):
            guard let voteProcessCell = tableView.dequeueReusableCell(withIdentifier: VoteProcessId.voteProcessCell, for: indexPath) as? VoteProcessTableViewCell else { return UITableViewCell() }
            voteProcessCell.selectionStyle = .none
            voteProcessCell.reactor = cellReactor
            return voteProcessCell
        }
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        profileView.addSubview(faceImageView)
        view.addSubviews(questionLabel, profileView, questionTableView, resultButton, voteBeginView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(30)
        }
        
        profileView.snp.makeConstraints {
            $0.size.equalTo(120)
            $0.top.equalTo(questionLabel.snp.bottom).offset(39)
            $0.centerX.equalToSuperview()
        }
        
        questionTableView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(364)
        }
        
        faceImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        resultButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
        }
        
        voteBeginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(
                property: .all(
                    DesignSystemAsset.Images.arrow.image,
                    VoteProcessStr.voteProcessTopText,
                    "1/5",
                    DesignSystemAsset.Colors.gray300.color
                )
            )
            $0.setNavigationBarAutoLayout(property: .all)
        }
        
        questionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        profileView.do {
            $0.layer.cornerRadius = 120 / 2
            $0.clipsToBounds = true
            $0.backgroundColor = DesignSystemAsset.Colors.primary100.color
        }
        
        faceImageView.do {
            $0.image = DesignSystemAsset.Images.icCommonProfile427323024.image
            $0.contentMode = .scaleToFill
        }
        
        questionTableView.do {
            $0.register(VoteProcessTableViewCell.self, forCellReuseIdentifier: VoteProcessId.voteProcessCell)
            $0.rowHeight = 72
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
        }
        
        resultButton.do {
            $0.setupButton(text: VoteProcessStr.voteResultText)
            $0.setupFont(font: .Body03)
            $0.isHidden = true
        }
        
        voteBeginView.do {
            $0.isHidden = true
            $0.backgroundColor = DesignSystemAsset.Colors.gray900.color
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .take(1)
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isInviteView)
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: voteBeginView.rx.isHidden)
            .disposed(by: disposeBag)

        voteBeginView.inviteButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.shareToKakaoTalk()
            }
            .disposed(by: disposeBag)
        
        navigationBar.rightBarButton
            .rx.tap
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.createAlertController()
            }
            .disposed(by: disposeBag)
        
        questionTableView.rx
            .itemSelected
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedQuestionItem($0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        resultButton.rx
            .tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTappedResultButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
   
        Observable
            .zip (
                reactor.state.map { $0.processCount },
                reactor.state.compactMap { $0.voteResponseEntity?.response.count }
            )
            .observe(on: MainScheduler.asyncInstance)
            .map { "\($0.0)/\($0.1)"}
            .distinctUntilChanged()
            .bind(to: navigationBar.navigationTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        Observable
            .zip(
                reactor.state.compactMap { $0.voteResponseEntity?.response.count },
                reactor.state.map { $0.processCount }
            )
            .map { $0.0 != $0.1 }
            .observe(on: MainScheduler.asyncInstance )
            .distinctUntilChanged()
            .bind(to: resultButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(
                reactor.pulse(\.$voteResponseEntity),
                reactor.pulse(\.$voteOptionsStub),
                reactor.pulse (\.$processCount )
            )
            .filter { $0.1.count == $0.2 && $0.0?.response.count != $0.2 }
            .compactMap { ($0.0, $0.1, $0.2 + 1) }
            .bind(with: self) { owner, response in
                let voteProcessViewController = DependencyContainer.shared.injector.resolve(VoteProcessViewController.self, arguments: response.0, response.1, response.2)
                owner.navigationController?.pushViewController(voteProcessViewController, animated: true)
            }
            .disposed(by: disposeBag)

        
        reactor.state
            .compactMap { $0.createVoteEntity }
            .distinctUntilChanged()
            .bind(with: self) { owner, response in
                let voteCompleteViewController = DependencyContainer.shared.injector.resolve(VoteCompleteViewController.self)
                owner.navigationController?.pushViewController(voteCompleteViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { !$0.isLoading }
            .distinctUntilChanged()
            .bind(to: profileView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .bind(to: loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$questionSection)
            .asDriver(onErrorJustReturn: [])
            .drive(questionTableView.rx.items(dataSource: questionDataSources))
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.voteUserEntity }
            .map { "\($0.name)님은 반에서 어떤 친구인가요?" }
            .distinctUntilChanged()
            .bind(to: questionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.voteUserEntity?.profileInfo }
            .map { UIColor(hex: $0.backgroundColor) }
            .distinctUntilChanged()
            .bind(to: profileView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.voteUserEntity?.profileInfo.iconUrl }
            .distinctUntilChanged()
            .bind(with: self) { owner, imageURL in
                owner.faceImageView.kf.setImage(with: imageURL)
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$reportEntity)
            .filter { $0 != nil }
            .bind(with: self) { owner, _ in
                owner.showWSToast(image: .check, message: VoteProcessStr.voteToastText)
            }
            .disposed(by: disposeBag)
    }
}


extension VoteProcessViewController {
    private func createAlertController() {
        let processAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reportAction = UIAlertAction(title: VoteProcessStr.voteReportAlertText, style: .default) { _ in
            WSAlertBuilder(showViewController: self)
                .setAlertType(type: .titleWithMeesage)
                .setTitle(title: VoteProcessStr.voteModalTitleText, titleAlignment: .left)
                .setMessage(message: VoteProcessStr.voteModalMessageText)
                .setConfirm(text: VoteProcessStr.voteModalConfirmText)
                .setCancel(text: VoteProcessStr.voteModalCancelText)
                .action(.confirm) { [weak self] in
                    self?.reactor?.action.onNext(.didTappedReportButton)
                }
                .show()
        }
        //TODO: 링크 주어질시 Action 추가하기
        let choiceAction = UIAlertAction(title: VoteProcessStr.voteChoiceAlertText, style: .default)
        let cancelAction = UIAlertAction(title: VoteProcessStr.voteCancelAlertText, style: .cancel)
        
        processAlertController.addAction(reportAction)
        processAlertController.addAction(choiceAction)
        processAlertController.addAction(cancelAction)
        
        present(processAlertController, animated: true)
    }
}
