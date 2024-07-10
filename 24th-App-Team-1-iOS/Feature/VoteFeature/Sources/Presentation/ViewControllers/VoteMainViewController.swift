//
//  VoteMainViewController.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/11/24.
//

import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import DesignSystem

public final class VoteMainViewController: BaseViewController<VoteMainViewReactor> {
    
    private let voteBannerView: WSBanner = WSBanner(
        image: DesignSystemAsset.Images.invite.image,
        titleText: "위스팟에 친구 초대하기",
        subText: "다양한 친구들과 더 재밌게 사용해 보세요"
    )
    private let voteContainerView: UIView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18
    }
    
    private let voteConfrimButton: WSButton = WSButton(wsButtonType: .default(12)).then {
        $0.setupButton(text: "투표하기")
    }
    
    private let voteDateLabel: WSLabel = WSLabel(wsFont: .Body06).then {
        $0.text = Date().toFormatString(with: "MM월 DD일 EEE")
        $0.textColor = DesignSystemAsset.Colors.gray300.color
    }
    
    private let voteDescriptionLabel: WSLabel = WSLabel(wsFont: .Body01).then {
        $0.text = "지금 우리 반 투표가 진행 중이에요\n반 친구들에 대해 알려주세요"
        $0.textColor = DesignSystemAsset.Colors.gray100.color
    }
    
    
    //TODO: SVG 파일 추가시 작업
    private let voteImageView: UIImageView = UIImageView()
    
    
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        voteContainerView.addSubviews(voteConfrimButton, voteDateLabel, voteDescriptionLabel)
        view.addSubviews(voteBannerView, voteContainerView)
    }

    public override func setupAutoLayout() {
        super.setupAutoLayout()
        voteBannerView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        
        voteContainerView.snp.makeConstraints {
            $0.top.equalTo(voteBannerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
    }

    public override func setupAttributes() {
        super.setupAttributes()
        navigationBar
            .setNavigationBarUI(property: .default)
            .setNavigationBarAutoLayout(property: .default)

    }

    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)

    }
}
