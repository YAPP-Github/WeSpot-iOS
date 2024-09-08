//
//  VoteHighCollectionViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/29/24.
//

import DesignSystem
import UIKit

import ReactorKit
import RxCocoa
import Kingfisher

final class VoteHighCollectionViewCell: UICollectionViewCell {
    
    private let rankerImageView: UIImageView = UIImageView()
    private let highContainerView: UIView = UIView()
    private let profileContainerView: UIView = UIView()
    private let profileImageView: UIImageView = UIImageView()
    private let voteCountLabel: WSLabel = WSLabel(wsFont: .Body01)
    private let userNameLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let effectView: UIBlurEffect = UIBlurEffect(style: .dark)
    private lazy var visualEffectView: WSIntensityVisualEffectView = WSIntensityVisualEffectView(effect: effectView, intensity: 0.15)
    private let profileIntroduceLabel: WSLabel = WSLabel(wsFont: .Badge)
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        profileContainerView.addSubview(profileImageView)
        highContainerView.addSubviews(profileContainerView, voteCountLabel, profileIntroduceLabel, userNameLabel, rankerImageView)
        contentView.addSubviews(highContainerView, visualEffectView)
    }
    
    private func setupAutoLayout() {
        
        
        rankerImageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        highContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        voteCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.height.equalTo(27)
            $0.centerX.equalToSuperview()
        }
        
        profileContainerView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.top.equalTo(voteCountLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        visualEffectView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-20)
            $0.left.right.bottom.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(4)
            $0.height.equalTo(27)
            $0.centerX.equalToSuperview()
        }
        
        profileIntroduceLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(36)
        }
        
    }
    
    private func setupAttributes() {
        
        highContainerView.do {
            $0.layer.cornerRadius = 12
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
        }
        
        rankerImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = DesignSystemAsset.Images.icCompleteGoldCrownFiled.image
        }
        
        voteCountLabel.do {
            $0.text = "10표"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        profileContainerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.primary100.color
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 48 / 2
        }
        
        visualEffectView.do {
            $0.isHidden = true
            $0.clipsToBounds = true
        }
        
        profileImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = DesignSystemAsset.Images.imgVoteProfileBlueFiled.image
        }
        
        userNameLabel.do {
            $0.text = "은미쿠"
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        profileIntroduceLabel.do {
            $0.text = "안녕하세요저는아아박주현이에요..."
            $0.textAlignment = .center
            $0.textColor = DesignSystemAsset.Colors.gray300.color
            $0.lineBreakStrategy = .hangulWordPriority
            $0.lineBreakMode = .byTruncatingTail
        }
        
        
    }
}


extension VoteHighCollectionViewCell: ReactorKit.View {
    
    func bind(reactor: VoteHighCellReactor) {
        reactor.pulse(\.$highUser)
            .map { $0.introduction }
            .bind(to: profileIntroduceLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$highUser)
            .map { $0.name }
            .bind(to: userNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$highUser)
            .map { UIColor(hex: $0.profile.backgroundColor) }
            .distinctUntilChanged()
            .bind(to: profileContainerView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$highUser)
            .map { $0.profile.iconUrl}
            .bind(with: self) { owner, iconURL in
                owner.profileImageView.kf.setImage(with: iconURL)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { "\($0.voteCount)표" }
            .distinctUntilChanged()
            .bind(to: voteCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.ranker == 1}
            .map { _ in DesignSystemAsset.Colors.primary300.color}
            .bind(to: voteCountLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .withUnretained(self)
            .map { $0.0.updateHighRankerImage(ranker: $0.1.ranker) }
            .bind(to: rankerImageView.rx.image)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.voteCount == 0 }
            .withUnretained(self)
            .map { $0.0.updateHighRankerBackgroundImage(ranker: $0.1.ranker)}
            .bind(to: profileImageView.rx.image)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.voteCount != 0 }
            .bind(to: visualEffectView.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
}


extension VoteHighCollectionViewCell {
    private func updateHighRankerImage(ranker: Int) -> UIImage {
        switch ranker {
        case 0:
            return DesignSystemAsset.Images.icCompleteSilverCrownFiled.image
        case 1:
            return DesignSystemAsset.Images.icCompleteGoldCrownFiled.image
        case 2:
            return DesignSystemAsset.Images.icCompleteBrozeCrwonFiled.image
        default:
            return UIImage()
        }
    }
    
    private func updateHighRankerBackgroundImage(ranker: Int) -> UIImage {
        switch ranker {
        case 0:
            return DesignSystemAsset.Images.imgVoteProfileBlueFiled.image
        case 1:
            return DesignSystemAsset.Images.imgVoteProfileYellowFiled.image
        case 2:
            return DesignSystemAsset.Images.imgVoteProfileTangerineFiled.image
        default:
            return UIImage()
        }
    }
}
