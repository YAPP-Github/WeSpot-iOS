//
//  SetUpProfileImageViewController.swift
//  LoginFeature
//
//  Created by eunseou on 8/3/24.
//

import UIKit
import Util
import Storage
import DesignSystem
import CommonDomain

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import RxDataSources
import Kingfisher

public final class SetUpProfileImageViewController: BaseViewController<SetUpProfileImageViewReactor> {
    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Header01)
    private let collectionViewStateLabel = WSLabel(wsFont: .Body06)
    private let characterButton = WSToggleProfileTableViewButton(profileButtonType: .character)
    private let backgroundButton = WSToggleProfileTableViewButton(profileButtonType: .background)
    private let loadingIndicator: WSLottieIndicatorView = WSLottieIndicatorView()
    private let characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private let backgroundCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private let userCharacterImageView = UIImageView()
    private let userBackgroundView = UIView()
    private let comfirmButton = WSButton(wsButtonType: .default(12))
    private lazy var characterCollectionViewDataSources = RxCollectionViewSectionedReloadDataSource<SignUpCharacterSection>(configureCell: { _, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .characterItem(cellReactor):
            guard let signUpCharacterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpProfileCharacterCollectionViewCell", for: indexPath) as? SignUpProfileCharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            signUpCharacterCell.reactor = cellReactor
            return signUpCharacterCell
        }
    })
    private lazy var backgroundCollectionViewDataSources = RxCollectionViewSectionedReloadDataSource<SignUpBackgroundSection>(configureCell: { _, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .backgroundItem(cellReactor):
            guard let signUpBackgroundCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpProfileBackgroundCollectionViewCell", for: indexPath) as? SignUpProfileBackgroundCollectionViewCell else {
                return UICollectionViewCell()
            }
            signUpBackgroundCell.reactor = cellReactor
            return signUpBackgroundCell
        }
    })
    
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .hideTabBar, object: nil)
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(titleLabel, userBackgroundView, userCharacterImageView, characterButton, backgroundButton, backgroundCollectionView, characterCollectionView, collectionViewStateLabel, comfirmButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        userBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(48)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(120)
        }
        
        userCharacterImageView.snp.makeConstraints {
            $0.center.equalTo(userBackgroundView)
            $0.size.equalTo(userBackgroundView).multipliedBy(0.7)
        }
        
        characterButton.snp.makeConstraints {
            $0.bottom.equalTo(characterCollectionView.snp.top).offset(-24)
            $0.centerX.equalTo(view.safeAreaLayoutGuide).offset(-80)  // 좌우 중앙 정렬에서 왼쪽으로 이동
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        
        backgroundButton.snp.makeConstraints {
            $0.bottom.equalTo(characterCollectionView.snp.top).offset(-24)
            $0.centerX.equalTo(view.safeAreaLayoutGuide).offset(80)  // 좌우 중앙 정렬에서 오른쪽으로 이동
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        
        backgroundCollectionView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(view)
            $0.height.equalTo(360)
        }
        
        characterCollectionView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(view)
            $0.height.equalTo(360)
        }
        
        collectionViewStateLabel.snp.makeConstraints {
            $0.top.leading.equalTo(characterCollectionView).offset(32)
        }
        
        comfirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .rightItem("닫기"))
            $0.setNavigationBarAutoLayout(property: .rightIcon(28, 24))
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "\(UserDefaultsManager.shared.userName ?? "User")님을 잘 나타낼 수 있는\n프로필을 선택해 주세요"
        }
        
        collectionViewStateLabel.do {
            $0.textColor = UIColor(hex: "#AEAFB4")
            $0.text = "캐릭터 고르기"
        }
        
        userCharacterImageView.do {
            $0.image = DesignSystemAsset.Images.icCommonProfile427323024.image
            $0.contentMode = .scaleAspectFit
        }
        
        userBackgroundView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray400.color
        }
        
        backgroundButton.do {
            $0.setSelectedState(false)
        }
        
        characterButton.do {
            $0.setSelectedState(true)
        }
        
        characterCollectionView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray600.color
            $0.register(SignUpProfileCharacterCollectionViewCell.self, forCellWithReuseIdentifier: "SignUpProfileCharacterCollectionViewCell")
        }
        
        backgroundCollectionView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray600.color
            $0.register(SignUpProfileBackgroundCollectionViewCell.self, forCellWithReuseIdentifier: "SignUpProfileBackgroundCollectionViewCell")
        }
        
        comfirmButton.do {
            $0.setupButton(text: "선택 완료")
        }
    }
    
    public override func viewDidLayoutSubviews() {
        userBackgroundView.do {
            $0.layer.cornerRadius = $0.bounds.height/2
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.fetchProfileImages }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable.just(())
            .map { Reactor.Action.fetchProfileBackgrounds }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .bind(to: loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        backgroundButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.toggleCollections(showCharacter: false)
            }
            .disposed(by: disposeBag)
        
        characterButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.toggleCollections(showCharacter: true)
            }
            .disposed(by: disposeBag)
        
        
        backgroundCollectionView
            .rx.itemSelected
            .map { Reactor.Action.didTappedBackgroundItem($0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
 
        characterCollectionView
            .rx.itemSelected
            .map { Reactor.Action.didTappedCharacterItem($0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map{ $0.backgroundSection }
            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
            .drive(backgroundCollectionView.rx.items(dataSource: backgroundCollectionViewDataSources))
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.characterSection }
            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
            .drive(characterCollectionView.rx.items(dataSource: characterCollectionViewDataSources))
            .disposed(by: disposeBag)
            
        
        reactor.state
            .map { UIColor(hex: $0.backgroundColor) }
            .bind(to: userBackgroundView.rx.backgroundColor)
            .disposed(by: disposeBag)
            
        
        reactor.state
            .map { $0.iconURL }
            .bind(with: self) { owner, iconURL in
                owner.userCharacterImageView.kf.setImage(with: iconURL)
            }
            .disposed(by: disposeBag)
        
        navigationBar.rightBarButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                WSAlertBuilder(showViewController: owner)
                    .setAlertType(type: .titleWithMeesage)
                    .setTitle(title: "프로필 설정을 중단하시나요?", titleAlignment: .left)
                    .setMessage(message: "선택하셨던 캐릭터와 배경색은 저장되지 않으며 \n기본 캐릭터와 배경색으로 자동 설정됩니다")
                    .setCancel(text: "닫기")
                    .setConfirm(text: "네 중단할래요")
                    .show()
            }
            .disposed(by: disposeBag)
        
        comfirmButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpIntroduceViewController = DependencyContainer.shared.injector.resolve(SignUpIntroduceViewController.self)
                self.navigationController?.pushViewController(signUpIntroduceViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        

    }
    
    private static func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 24
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 77, left: 32, bottom: 143, right: 31)
        
        return layout
    }
    
    private func toggleCollections(showCharacter: Bool) {
        characterCollectionView.isHidden = !showCharacter
        backgroundCollectionView.isHidden = showCharacter
        characterButton.setSelectedState(showCharacter)
        backgroundButton.setSelectedState(!showCharacter)
        collectionViewStateLabel.text = showCharacter ? "캐릭터 고르기" : "배경색 고르기"
    }
}
