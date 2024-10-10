//
//  VoteBeginViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 10/10/24.
//

import UIKit
import DesignSystem
import Storage
import Util

import SnapKit
import Then
import RxSwift
import RxCocoa


fileprivate typealias VoteBeginStr = VoteStrings
public final class VoteBeginViewController: BaseViewController<VoteBeginViewReactor> {
    //MARK: - Properties
    private let beginInfoLabel: WSLabel = WSLabel(wsFont: .Header01)
    let inviteButton: WSButton = WSButton(wsButtonType: .default(12))
    private let beginImageView: UIImageView = UIImageView()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(beginInfoLabel, beginImageView, inviteButton)
    }
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        beginInfoLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        beginImageView.snp.makeConstraints {
            $0.top.equalTo(beginInfoLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(292)
        }
        
        inviteButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(33)
            $0.height.equalTo(52)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        beginInfoLabel.do {
            guard let grade = UserDefaultsManager.shared.grade,
                  let classNumber = UserDefaultsManager.shared.classNumber else { return }
            $0.text = "투표할 수 있는\n\(grade)학년 \(classNumber)반 친구들이 부족해요"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        beginImageView.do {
            $0.image = DesignSystemAsset.Images.imgEmptyFriendFiled.image
        }
        
        inviteButton.do {
            $0.setupButton(text: VoteBeginStr.voteInviteButtonText)
        }
        
        navigationBar.do {
            $0.setNavigationBarUI(
                property: .leftIcon(DesignSystemAsset.Images.arrow.image)
            )
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
    }
    
    public override func bind(reactor: VoteBeginViewReactor) {
        inviteButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.shareToKakaoTalk()
            }
            .disposed(by: disposeBag)
    }
}
