//
//  ProfileResignNoteViewController.swift
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

public final class ProfileResignNoteViewController: BaseViewController<ProfileResignNoteViewReactor> {

    //MARK: - Properties
    private let noteTitleLabel: WSLabel = WSLabel(wsFont: .Header01)
    private let noteWarningImageView: UIImageView = UIImageView()
    private let noteSubTitleLabel: WSLabel = WSLabel(wsFont: .Body03)
    private let noteDescriptionLabel: WSLabel = WSLabel(wsFont: .Body06)
    private let noteWarningLabel: WSLabel = WSLabel(wsFont: .Body08)
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    
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
        view.addSubviews(noteTitleLabel, noteWarningImageView, noteSubTitleLabel, noteDescriptionLabel, noteWarningLabel, confirmButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        noteTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        noteWarningImageView.snp.makeConstraints {
            $0.top.equalTo(noteTitleLabel.snp.bottom).offset(28)
            $0.size.equalTo(24)
            $0.left.equalToSuperview().inset(30)
        }
        
        noteSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(noteTitleLabel.snp.bottom).offset(28)
            $0.left.equalTo(noteWarningImageView.snp.right).offset(6)
            $0.height.equalTo(24)
        }
        
        noteDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(noteSubTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(63)
        }
        
        noteWarningLabel.snp.makeConstraints {
            $0.top.equalTo(noteDescriptionLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(20)
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
            $0.setNavigationBarUI(property: .leftWithCenterItem(DesignSystemAsset.Images.arrow.image, "회원 탈퇴"))
            $0.setNavigationBarAutoLayout(property: .leftWithCenterItem)
        }
        
        noteTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "김선희님\n위스팟을 떠나시나요? 너무 아쉬워요"
            $0.textAlignment = .left
        }
        
        noteWarningImageView.do {
            $0.image = DesignSystemAsset.Images.exclamationmarkFillDestructive.image
        }
        
        noteSubTitleLabel.do {
            $0.text = "유의사항"
            $0.textAlignment = .left
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        noteDescriptionLabel.do {
            $0.text = "위스팟에서 친구들과 함께 했던 추억들\n(투표, 쪽지 등 모든 활동 정보)이 영구적으로 사라져요\n해당 데이터는 탈퇴 후 복구할 수 없어요"
            $0.textAlignment = .left
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        noteWarningLabel.do {
            $0.text = "* 예약 중인 쪽지는 자동으로 발송 예약이 취소돼요"
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.textAlignment = .left
        }
        
        confirmButton.do {
            $0.setupFont(font: .Body03)
            $0.setupButton(text: "추억 보내기")
        }
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        confirmButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let profileResignViewController = DependencyContainer.shared.injector.resolve(ProfileResignViewController.self)
                owner.navigationController?.pushViewController(profileResignViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
