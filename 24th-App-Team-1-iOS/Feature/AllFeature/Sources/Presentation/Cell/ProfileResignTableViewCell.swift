//
//  ProfileResignTableViewCell.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/17/24.
//

import DesignSystem
import UIKit

import ReactorKit

public final class ProfileResignTableViewCell: UITableViewCell {
    
    private let resignContainerView: UIView = UIView()
    private let reasonTitleLabel: WSLabel = WSLabel(wsFont: .Body04)
    private let checkImageView: UIImageView = UIImageView()
    public var disposeBag: DisposeBag = DisposeBag()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupAttributes()
        setupAutoLayout()
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        resignContainerView.addSubviews(checkImageView, reasonTitleLabel)
        contentView.addSubview(resignContainerView)
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .clear
        }
        
        resignContainerView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
            $0.layer.borderWidth = 0
            $0.layer.borderColor = DesignSystemAsset.Colors.primary400.color.cgColor
        }
        
        checkImageView.do {
            $0.image = DesignSystemAsset.Images.check.image
        }
        
        reasonTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.textAlignment = .left
        }
    }
    
    private func setupAutoLayout() {
        resignContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        checkImageView.snp.makeConstraints {
            $0.size.equalTo(26)
            $0.left.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        reasonTitleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.left.equalTo(checkImageView.snp.right).offset(7)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func updateContainerView(isSelected: Bool) {
        resignContainerView.layer.borderWidth = isSelected ? 1 : 0
        checkImageView.image = isSelected ? DesignSystemAsset.Images.checkSelected.image :  DesignSystemAsset.Images.check.image
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        updateContainerView(isSelected: selected)
    }
}


extension ProfileResignTableViewCell: ReactorKit.View {
    
    public func bind(reactor: ProfileResignCellReactor) {
        reactor.state
            .map { $0.contentTitle }
            .distinctUntilChanged()
            .bind(to: reasonTitleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
