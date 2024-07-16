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

fileprivate typealias VoteProcessStr = VoteStrings
final class VoteProcessViewController: BaseViewController<VoteProcessViewReactor> {

    //MARK: - Properties
    private let profileImageView: UIImageView = UIImageView()
    private let questionLabel: WSLabel = WSLabel(wsFont: .Header01, text: "김쥬시님은 반에서 어떤 친구인가요?")
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    override func setupUI() {
        super.setupUI()
        view.addSubviews(questionLabel, profileImageView)
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
    }
    
    override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(
                property: .all(DesignSystemAsset.Images.arrow.image, "1/5", VoteProcessStr.voteProcessTopTexxt)
            )
            $0.setNavigationBarAutoLayout(property: .all)
        }
        
        questionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        profileImageView.do {
            $0.image = DesignSystemAsset.Images.boy.image
        }
    }
    
    override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
    }
}
