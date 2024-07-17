//
//  VoteProcessViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
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

fileprivate typealias VoteProcessStr = VoteStrings
fileprivate typealias VoteProcessId = VoteStrings.Identifier
final class VoteProcessViewController: BaseViewController<VoteProcessViewReactor> {

    //MARK: - Properties
    private let profileImageView: UIImageView = UIImageView()
    private let questionLabel: WSLabel = WSLabel(wsFont: .Header01, text: "김쥬시님은 반에서 어떤 친구인가요?")
    private let questionTableView: UITableView = UITableView()
    private let questionDataSources: RxTableViewSectionedReloadDataSource<VoteProcessSection> = .init { dataSources, tableView, indexPath, sectionItem in
        
        guard let votePrcessCell = tableView.dequeueReusableCell(withIdentifier: VoteProcessId.voteProcessCell, for: indexPath) as? VoteProcessTableViewCell else { return UITableViewCell() }
        
        return votePrcessCell
    }

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    override func setupUI() {
        super.setupUI()
        view.addSubviews(questionLabel, profileImageView, questionTableView)
    }
    
    override func setupAutoLayout() {
        super.setupAutoLayout()
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(30)
        }
        
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(120)
            $0.top.equalTo(questionLabel.snp.bottom).offset(39)
            $0.centerX.equalToSuperview()
        }
        
        questionTableView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(364)
        }
    }
    
    override func setupAttributes() {
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
        
        profileImageView.do {
            $0.image = DesignSystemAsset.Images.boy.image
        }
        
        questionTableView.do {
            $0.register(VoteProcessTableViewCell.self, forCellReuseIdentifier: VoteProcessId.voteProcessCell)
            $0.rowHeight = 72
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
        }
    }
    
    override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.fetchQuestionItems }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$questionSection)
            .asDriver(onErrorJustReturn: [])
            .drive(questionTableView.rx.items(dataSource: questionDataSources))
            .disposed(by: disposeBag)
        
        navigationBar
            .rightBarButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.createAlertController()
            }
            .disposed(by: disposeBag)
    }
}


extension VoteProcessViewController {
    
    func createAlertController() {
        let processAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reportAction = UIAlertAction(title: VoteProcessStr.voteReportAlertText, style: .default) { _ in
            WSAlertBuilder(showViewController: self)
                .setTitle(title: VoteProcessStr.voteModalTitleText)
                .setMessage(message: VoteProcessStr.voteModalMessageText)
                .setConfirm(text: VoteProcessStr.voteModalConfirmText)
                .setCancel(text: VoteProcessStr.voteModalCancelText)
                .action(.confirm) { [weak self] in
                    self?.showWSToast(image: .check, message: VoteProcessStr.voteToastText)
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
