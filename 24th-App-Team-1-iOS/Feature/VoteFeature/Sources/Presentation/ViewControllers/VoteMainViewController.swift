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
        $0.text = Date().toFormatString(with: .MddEEE)
        $0.textColor = DesignSystemAsset.Colors.gray300.color
    }
    
    private let voteDescriptionLabel: WSLabel = WSLabel(wsFont: .Body01).then {
        $0.text = "지금 우리 반 투표가 진행 중이에요\n반 친구들에 대해 알려주세요"
        $0.textColor = DesignSystemAsset.Colors.gray100.color
    }
    
    private let voteImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = DesignSystemAsset.Images.voteSymbol.image
    }
    
    
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        voteContainerView.addSubviews(voteConfrimButton, voteDateLabel, voteImageView, voteDescriptionLabel)
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
        
        voteDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(21)
        }
        
        voteDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(voteDateLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(54)
        }
        
        voteImageView.snp.makeConstraints {
            $0.top.equalTo(voteDescriptionLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        voteConfrimButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-28)
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


//TODO: WSTabbarViewController를 어디 항목에 넣어야 할지 논의
// - App Module에 넣어서 하위 Feature 의존성을 모두 관리 해야 할 듯한데 의존성 라이브러리 잘 몰라서 모르겠음
public final class WSTabBarViewController: UITabBarController {
    
    private let voteViewController: VoteMainViewController = VoteMainViewController()
    //TODO: ViewController 임시 네이밍 입니다 추후 수정해주세요
    private let noteViewControlelr: UIViewController = UIViewController()
    private let allViewControlelr: UIViewController = UIViewController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        let voteViewController = UINavigationController(rootViewController: voteViewController)
        let noteViewController = UINavigationController(rootViewController: noteViewControlelr)
        let allViewController = UINavigationController(rootViewController: allViewControlelr)
        
        voteViewController.tabBarItem = .init(
            title: "투표",
            image: DesignSystemAsset.Images.voteUnSeleceted.image,
            selectedImage: DesignSystemAsset.Images.voteSelected.image
        )
        
        noteViewController.tabBarItem = .init(
            title: "쪽지",
            image: DesignSystemAsset.Images.heartUnSelected.image,
            selectedImage: DesignSystemAsset.Images.heartSelected.image
        )
        
        allViewController.tabBarItem = .init(
            title: "전체",
            image: DesignSystemAsset.Images.allUnSelected.image,
            selectedImage: DesignSystemAsset.Images.allSelected.image
        )
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        UITabBar.appearance().backgroundColor = DesignSystemAsset.Colors.gray800.color
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = DesignSystemAsset.Colors.gray200.color
        UITabBar.appearance().unselectedItemTintColor = DesignSystemAsset.Colors.gray400.color
        appearance.stackedItemWidth = 40
        appearance.stackedItemPositioning = .centered
        appearance.stackedItemSpacing = 60
        
        self.tabBar.standardAppearance = appearance
        self.viewControllers = [voteViewController, noteViewController, allViewController]
    }
}
