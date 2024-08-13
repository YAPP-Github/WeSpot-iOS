//
//  ProfileEditViewController.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/12/24.
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

public final class ProfileEditViewController: BaseViewController<ProfileEditViewReactor> {

    //MARK: - Properties
    private let userDescrptionLabel: WSLabel = WSLabel(wsFont: .Header01)
    private let profileContainerView: UIView = UIView()
    private let profileImageView: UIImageView = UIImageView()
    private let characterEditButton: WSToggleProfileTableViewButton = WSToggleProfileTableViewButton(profileButtonType: .character)
    private let backgroundEditButton: WSToggleProfileTableViewButton = WSToggleProfileTableViewButton(profileButtonType: .background)
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    private let descrptionLabel: WSLabel = WSLabel(wsFont: .Body06)
    private lazy var editCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var editCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: editCollectionViewLayout)
    private lazy var editCollectionViewDataSources: RxCollectionViewSectionedReloadDataSource<ProfileEditSection> = .init { dataSources, collectionView, indexPath, sectionItem in
        switch sectionItem {
        case let .profileCharacterItem(cellReactor):
            guard let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCharacterCollectionViewCell", for: indexPath) as? ProfileCharacterCollectionViewCell else { return UICollectionViewCell() }
            characterCell.reactor = cellReactor
            return characterCell
        case let .profileBackgroundItem(cellReactor):
            guard let backgroundCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileBackgroundCollectionViewCell", for: indexPath) as? ProfileBackgroundCollectionViewCell else { return UICollectionViewCell() }
            backgroundCell.reactor = cellReactor
            return backgroundCell
        }
    }
    
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        profileContainerView.addSubview(profileImageView)
        view.addSubviews(userDescrptionLabel, profileContainerView, characterEditButton, backgroundEditButton, editCollectionView, descrptionLabel ,confirmButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        userDescrptionLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        profileContainerView.snp.makeConstraints {
            $0.size.equalTo(120)
            $0.top.equalTo(userDescrptionLabel.snp.bottom).offset(48)
            $0.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        characterEditButton.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(56)
            $0.left.equalToSuperview().inset(30)
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        
        
        backgroundEditButton.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(56)
            $0.right.equalToSuperview().inset(30)
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        
        descrptionLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundEditButton.snp.bottom).offset(56)
            $0.left.equalToSuperview().inset(33)
            $0.width.equalTo(77)
            $0.height.equalTo(21)
        }
        
        editCollectionView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(backgroundEditButton.snp.bottom).offset(24)
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
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        userDescrptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        profileContainerView.do {
            $0.layer.cornerRadius = 120 / 2
            $0.clipsToBounds = true
        }
        
        profileImageView.do {
            $0.image = DesignSystemAsset.Images.girl.image
        }
        
        editCollectionView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray600.color
            $0.register(ProfileBackgroundCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileBackgroundCollectionViewCell")
            $0.register(ProfileCharacterCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCharacterCollectionViewCell")
        }
        
        descrptionLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        
        editCollectionViewLayout.do {
            $0.itemSize = CGSize(width: 60, height: 60)
            $0.minimumLineSpacing = 24
            $0.minimumInteritemSpacing = 24
            $0.scrollDirection = .vertical
            $0.sectionInset = UIEdgeInsets(top: 77, left: 32, bottom: 143, right: 31)
        }
        
        characterEditButton.do {
            $0.setSelectedState(true)
        }
        
        backgroundEditButton.do {
            $0.setSelectedState(false)
        }
        
        confirmButton.do {
            $0.setupFont(font: .Body03)
            $0.setupButton(text: "수정 완료")
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        Observable.just(())
            .map { Reactor.Action.fetchProfileImageItem }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        editCollectionView
            .rx.itemSelected
            .map { Reactor.Action.didTappedEditItem($0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        backgroundEditButton
            .rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.fetchProfileBackgrounItem }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        characterEditButton
            .rx.tap
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.fetchProfileImageItem }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.isToggle }
            .distinctUntilChanged()
            .bind(with: self) { owner, isSelected in
                let descrptionText = isSelected == true ? "캐릭터 고르기" : "배경색 고르기"
                owner.characterEditButton.setSelectedState(isSelected)
                owner.backgroundEditButton.setSelectedState(!isSelected)
                owner.descrptionLabel.text = descrptionText
            }
            .disposed(by: disposeBag)


        reactor.state
            .compactMap { "\($0.userProfileEntity.name)잘 나타낼 수 있는\n프로필을 선택해 주세요"}
            .distinctUntilChanged()
            .bind(to: userDescrptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.userProfileEntity.profile.backgroundColor }
            .map {UIColor(hex: $0) }
            .distinctUntilChanged()
            .bind(to: profileContainerView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$profileEditSection)
            .observe(on: MainScheduler.asyncInstance)
            .asDriver(onErrorJustReturn: [])
            .drive(editCollectionView.rx.items(dataSource: editCollectionViewDataSources))
            .disposed(by: disposeBag)
    }
}
