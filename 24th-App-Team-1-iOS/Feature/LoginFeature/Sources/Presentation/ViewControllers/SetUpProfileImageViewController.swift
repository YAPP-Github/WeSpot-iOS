//
//  SetUpProfileImageViewController.swift
//  LoginFeature
//
//  Created by eunseou on 8/3/24.
//

import UIKit
import Util
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
    private let characterButton = ToggleProfileTableViewButton(profileButtonType: .character)
    private let backgroundButton = ToggleProfileTableViewButton(profileButtonType: .background)
    private lazy var characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private lazy var backgroundCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private let userCharacterImageView = UIImageView()
    private let userBackgroundView = UIView()
    private let comfirmButton = WSButton(wsButtonType: .default(12))
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(titleLabel, userBackgroundView, userCharacterImageView, characterButton, backgroundButton, backgroundCollectionView, characterCollectionView, comfirmButton)
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
            $0.text = "김은수님을 잘 나타낼 수 있는\n프로필을 선택해 주세요"
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
            $0.backgroundColor = .blue
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
        
        // Characters 바인딩
        reactor.pulse(\.$profileImages)
            .compactMap { $0?.characters }
            .bind(to: characterCollectionView.rx.items(cellIdentifier: ProfileCharacterImageViewCollectionViewCell.identifier, cellType: ProfileCharacterImageViewCollectionViewCell.self)) { row, image, cell in
                
                cell.configureCell(image: image.iconUrl)
            }
            .disposed(by: disposeBag)
        
        // Backgrounds 바인딩
        reactor.pulse(\.$profileBackgrounds)
            .compactMap { $0?.backgrounds }
            .bind(to: backgroundCollectionView.rx.items(cellIdentifier: ProfileBackgroundColorCollectionViewCell.identifier, cellType: ProfileBackgroundColorCollectionViewCell.self)) { row, background, cell in
                
                cell.configureCell(background: background.color)
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
    
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
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
    }
}
