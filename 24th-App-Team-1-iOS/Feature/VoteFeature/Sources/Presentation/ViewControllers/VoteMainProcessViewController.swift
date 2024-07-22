//
//  VoteMainProcessViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/18/24.
//

import DesignSystem
import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

fileprivate typealias VoteMainProcessStr = VoteStrings
fileprivate typealias VoteMainProcessId = VoteStrings.Identifier
final class VoteMainProcessViewController: BaseViewController<VoteMainProcessViewReactor> {

    //MARK: - Properties
    
    //TODO: Swinject 라이브러리 사용시 리펙토링
    private lazy var voteProcessViewReactor: VoteProcessViewReactor = VoteProcessViewReactor()
    private lazy var voteProcessViewController: VoteProcessViewController = VoteProcessViewController(reactor: voteProcessViewReactor)
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Configure
    override func setupUI() {
        super.setupUI()
        addChild(voteProcessViewController)
        view.addSubview(voteProcessViewController.view)
        voteProcessViewController.didMove(toParent: self)
    }
    
    override func setupAutoLayout() {
        super.setupAutoLayout()
        voteProcessViewController.view.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        navigationBar.do {
            $0.setNavigationBarUI(
                property: .all(
                    DesignSystemAsset.Images.arrow.image,
                    VoteMainProcessStr.voteProcessTopText,
                    "1/5",
                    DesignSystemAsset.Colors.gray300.color
                )
            )
            $0.setNavigationBarAutoLayout(property: .all)
        }
        
    }
    
    override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        navigationBar
            .rightBarButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.createAlertController()
            }
            .disposed(by: disposeBag)
        
        
        
    }
}


extension VoteMainProcessViewController {
    private func createAlertController() {
        let processAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reportAction = UIAlertAction(title: VoteMainProcessStr.voteReportAlertText, style: .default) { _ in
            WSAlertBuilder(showViewController: self)
                .setTitle(title: VoteMainProcessStr.voteModalTitleText)
                .setMessage(message: VoteMainProcessStr.voteModalMessageText)
                .setConfirm(text: VoteMainProcessStr.voteModalConfirmText)
                .setCancel(text: VoteMainProcessStr.voteModalCancelText)
                .action(.confirm) { [weak self] in
                    self?.showWSToast(image: .check, message: VoteMainProcessStr.voteToastText)
                }
                .show()
        }
        //TODO: 링크 주어질시 Action 추가하기
        let choiceAction = UIAlertAction(title: VoteMainProcessStr.voteChoiceAlertText, style: .default)
        let cancelAction = UIAlertAction(title: VoteMainProcessStr.voteCancelAlertText, style: .cancel)
        
        processAlertController.addAction(reportAction)
        processAlertController.addAction(choiceAction)
        processAlertController.addAction(cancelAction)
        
        present(processAlertController, animated: true)
    }
}
