//
//  MessageStorageViewController.swift
//  MessageFeature
//
//  Created by eunseou on 7/20/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit

public final class MessageStorageViewController: BaseViewController<MessageStorageViewReactor> {
    
    //MARK: - Properties
    private let receivedMessageButton = UIButton()
    private let sentMessageButton = UIButton()
    private let messageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Functions
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(receivedMessageButton, sentMessageButton, messageCollectionView)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        receivedMessageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.width.equalTo(76)
            $0.height.equalTo(31)
        }
        
        sentMessageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.leading.equalTo(receivedMessageButton.snp.trailing).offset(12)
            $0.width.equalTo(76)
            $0.height.equalTo(31)
        }
        
        messageCollectionView.snp.makeConstraints {
            $0.top.equalTo(receivedMessageButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        receivedMessageButton.do {
            $0.setTitle("받은 쪽지", for: .normal)
            $0.backgroundColor = UIColor.clear
            $0.titleLabel?.font = WSFont.Body06.font()
            $0.setTitleColor(DesignSystemAsset.Colors.gray400.color, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = DesignSystemAsset.Colors.gray400.color.cgColor
            $0.layoutIfNeeded()
            $0.layer.cornerRadius = $0.frame.height / 2
        }
        
        sentMessageButton.do {
            $0.setTitle("보낸 쪽지", for: .normal)
            $0.backgroundColor = UIColor.clear
            $0.titleLabel?.font = WSFont.Body06.font()
            $0.setTitleColor(DesignSystemAsset.Colors.gray400.color, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = DesignSystemAsset.Colors.gray400.color.cgColor
            $0.layoutIfNeeded()
            $0.layer.cornerRadius = $0.frame.height / 2
        }
        
        messageCollectionView.do {
            $0.backgroundColor = UIColor.clear
//            $0.register(MessageStorageCollectionViewCell.self, forCellWithReuseIdentifier: MessageStorageCollectionViewCell.identifier)
        }
    }
    
    static func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    public  override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        

    }
}
