//
//  VoteEmptyCollectionViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/31/24.
//

import DesignSystem
import UIKit

import ReactorKit


final class VoteEmptyCollectionViewCell: UICollectionViewCell {
    
    private let topRankerView: VoteHorizontalRankerView = VoteHorizontalRankerView()
    private let middleRankerView: VoteHorizontalRankerView = VoteHorizontalRankerView()
    private let bottomRankerView: VoteHorizontalRankerView = VoteHorizontalRankerView()
    private let fourthPositionView: VoteVerticalRankerView = VoteVerticalRankerView()
    private let fifthPositionView: VoteVerticalRankerView = VoteVerticalRankerView()
    private let effectView: UIBlurEffect = UIBlurEffect(style: .dark)
    private lazy var visualEffectView: WSIntensityVisualEffectView = WSIntensityVisualEffectView(effect: effectView, intensity: 0.15)
    private let emptyVoteTitleLabel: WSLabel = WSLabel(wsFont: .Header01)
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
        contentView.addSubviews(emptyVoteTitleLabel, topRankerView, middleRankerView, bottomRankerView, fourthPositionView, fifthPositionView,  visualEffectView)
    }
    
    private func setupAutoLayout() {
        
        emptyVoteTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        
        visualEffectView.snp.makeConstraints {
            $0.top.equalTo(emptyVoteTitleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        topRankerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(180)
            $0.top.equalTo(emptyVoteTitleLabel.snp.bottom).offset(40)
            $0.left.equalTo(middleRankerView.snp.right).offset(10)
        }

        middleRankerView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.width.equalTo(topRankerView.snp.width)
            $0.height.equalTo(180)
            $0.top.equalTo(emptyVoteTitleLabel.snp.bottom).offset(77)
        }

        bottomRankerView.snp.makeConstraints {
            $0.left.equalTo(topRankerView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(16)
            $0.width.equalTo(topRankerView.snp.width)
            $0.height.equalTo(180)
            $0.top.equalTo(emptyVoteTitleLabel.snp.bottom).offset(77)
        }
        
        fourthPositionView.snp.makeConstraints {
            $0.top.equalTo(bottomRankerView.snp.bottom).offset(36)
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        fifthPositionView.snp.makeConstraints {
            $0.top.equalTo(fourthPositionView.snp.bottom).offset(32)
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
    }
    
    private func setupAttributes() {
        
        emptyVoteTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        topRankerView.do {
            $0.crownImageView.image = DesignSystemAsset.Images.icCompleteGoldCrownFiled.image
            $0.profileImageView.image = DesignSystemAsset.Images.imgVoteProfileBlueFiled.image
            $0.rankLabel.text = "10표"
            $0.rankLabel.textColor = DesignSystemAsset.Colors.primary300.color
        }
        
        middleRankerView.do {
            $0.crownImageView.image = DesignSystemAsset.Images.icCompleteSilverCrownFiled.image
            $0.profileImageView.image = DesignSystemAsset.Images.imgVoteProfileYellowFiled.image
            $0.rankLabel.text = "9표"
            $0.rankLabel.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        bottomRankerView.do {
            $0.crownImageView.image = DesignSystemAsset.Images.icCompleteBrozeCrwonFiled.image
            $0.profileImageView.image = DesignSystemAsset.Images.imgVoteProfileTangerineFiled.image
            $0.rankLabel.text = "8표"
            $0.rankLabel.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        fourthPositionView.do {
            $0.rankerLabel.text = "4"
            $0.voteCountLabel.text = "6표"
            $0.profileImageView.image = DesignSystemAsset.Images.imgVoteProfileGrayFiled.image
        }
        
        fifthPositionView.do {
            $0.rankerLabel.text = "5"
            $0.voteCountLabel.text = "5표"
            $0.profileImageView.image = DesignSystemAsset.Images.imgVoteProfilePinkFiled.image
        }
        
        
    }
}

extension VoteEmptyCollectionViewCell: ReactorKit.View {

    func bind(reactor: VoteEmptyCellReactor) {
        reactor.state
            .map { $0.content }
            .distinctUntilChanged()
            .bind(to: emptyVoteTitleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
