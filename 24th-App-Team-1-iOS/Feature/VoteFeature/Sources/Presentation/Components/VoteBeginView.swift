//
//  VoteBeginView.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/16/24.
//

import DesignSystem
import UIKit
import Util
import Storage

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

fileprivate typealias VoteBeginStr = VoteStrings
public final class VoteBeginView: UIView {

    //MARK: - Properties
    private let beginInfoLabel: WSLabel = WSLabel(wsFont: .Header01)
    let inviteButton: WSButton = WSButton(wsButtonType: .default(12))
    private let beginImageView: UIImageView = UIImageView()
    
    //MARK: - LifeCycle
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    public func setupUI() {
        addSubviews(beginInfoLabel, beginImageView, inviteButton)
    }
    public func setupAutoLayout() {
        beginInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
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
    
    public func setupAttributes() {
        
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
    }
}
