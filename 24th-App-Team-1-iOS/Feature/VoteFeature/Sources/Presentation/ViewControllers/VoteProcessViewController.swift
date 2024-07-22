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
        votePrcessCell.selectionStyle = .none
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
            $0.top.equalToSuperview()
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
            $0.isScrollEnabled = false
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
        
    }
}
