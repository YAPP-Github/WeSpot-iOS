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

public final class SetUpProfileImageViewController: BaseViewController<SetUpProfileImageViewReactor> {
    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Header01)
    private let collectionViewStateLabel = WSLabel(wsFont: .Body06)
    private let characterButton = ToggleProfileTableViewButton(profileButtonType: .character)
    private let backgroundButton = ToggleProfileTableViewButton(profileButtonType: .background)
    private let characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private let backgroundCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private let userCharacterImageView = UIImageView()
    private let userBackgroundView = UIView()
    private let comfirmButton = WSButton(wsButtonType: .default(12))
    private lazy var characterCollectionViewDataSources = RxCollectionViewSectionedReloadDataSource<CharacterSection>(configureCell: { _, collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCharacterImageViewCollectionViewCell.identifier, for: indexPath) as? ProfileCharacterImageViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(image: item.iconUrl)
        return cell
    })
    private lazy var backgroundCollectionViewDataSources = RxCollectionViewSectionedReloadDataSource<BackgroundSection>(configureCell: { _, collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileBackgroundColorCollectionViewCell.identifier, for: indexPath) as? ProfileBackgroundColorCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(background: item.color)
        return cell
    })
    
    
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
            $0.setNavigationBarUI(property: .leftIcon(DesignSystemAsset.Images.arrow.image))
            $0.setNavigationBarAutoLayout(property: .leftIcon)
        }
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "\(UserDefaultsManager.shared.userProfile?.name ?? "User")님을 잘 나타낼 수 있는\n프로필을 선택해 주세요"
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
            $0.register(ProfileCharacterImageViewCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCharacterImageViewCollectionViewCell.identifier)
        }
        
        backgroundCollectionView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray600.color
            $0.register(ProfileBackgroundColorCollectionViewCell.self, forCellWithReuseIdentifier: ProfileBackgroundColorCollectionViewCell.identifier)
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
        
        reactor.action.onNext(.fetchProfileImages)
        reactor.action.onNext(.fetchProfileBackgrounds)
        
        reactor.pulse(\.$profileImages)
            .compactMap { $0?.characters }
            .map { [CharacterSection(items: $0)] }
            .bind(to: characterCollectionView.rx.items(dataSource: characterCollectionViewDataSources))
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$profileBackgrounds)
            .compactMap { $0?.backgrounds }
            .map { [BackgroundSection(items: $0)] }
            .bind(to: backgroundCollectionView.rx.items(dataSource: backgroundCollectionViewDataSources))
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.profileImages?.characters }
            .filter { $0 != nil && !$0!.isEmpty }
            .take(1)
            .bind(with: self) { owner, _ in
                DispatchQueue.main.async {
                    let indexPath = IndexPath(item: 0, section: 0)
                    owner.characterCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    owner.characterCollectionView.delegate?.collectionView?(owner.characterCollectionView, didSelectItemAt: indexPath)
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.profileBackgrounds?.backgrounds }
            .filter { $0 != nil && !$0!.isEmpty }
            .take(1)
            .bind(with: self) { owner, _ in
                DispatchQueue.main.async {
                    let indexPath = IndexPath(item: 0, section: 0)
                    owner.backgroundCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    owner.backgroundCollectionView.delegate?.collectionView?(owner.backgroundCollectionView, didSelectItemAt: indexPath)
                }
            }
            .disposed(by: disposeBag)
        
        backgroundCollectionView.rx.itemSelected
            .withLatestFrom(reactor.state.map { $0.profileBackgrounds }) { indexPath, profileBackgrounds in
                return (indexPath, profileBackgrounds?.backgrounds[indexPath.row])
            }
            .compactMap { $0.1 }
            .bind(with: self) { owner, background in
                owner.userBackgroundView.backgroundColor = UIColor(hex: background.color)
            }
            .disposed(by: disposeBag)
        
        backgroundCollectionView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                guard let cell = owner.backgroundCollectionView.cellForItem(at: indexPath) as? ProfileBackgroundColorCollectionViewCell else { return }
                cell.selectedCell()
            }
            .disposed(by: disposeBag)
        
        backgroundCollectionView.rx.itemDeselected
            .bind(with: self) { owner, indexPath in
                guard let cell = owner.backgroundCollectionView.cellForItem(at: indexPath) as? ProfileBackgroundColorCollectionViewCell else { return }
                cell.deselectCell()
            }
            .disposed(by: disposeBag)
        
        characterCollectionView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                guard let cell = owner.characterCollectionView.cellForItem(at: indexPath) as? ProfileCharacterImageViewCollectionViewCell else { return }
                cell.selectedCell()
            }
            .disposed(by: disposeBag)
        
        characterCollectionView.rx.itemDeselected
            .bind(with: self) { owner, indexPath in
                guard let cell = owner.characterCollectionView.cellForItem(at: indexPath) as? ProfileCharacterImageViewCollectionViewCell else { return }
                cell.deselectCell()
            }
            .disposed(by: disposeBag)
        
        characterButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.toggleCollections(showCharacter: true)
            }
            .disposed(by: disposeBag)
        
        backgroundButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.toggleCollections(showCharacter: false)
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
