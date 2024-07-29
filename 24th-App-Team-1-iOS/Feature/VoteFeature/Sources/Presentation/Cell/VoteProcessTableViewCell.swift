//
//  VoteProcessTableViewCell.swift
//  VoteFeature
//
//  Created by Kim dohyun on 7/17/24.
//

import DesignSystem
import UIKit

import ReactorKit

final class VoteProcessTableViewCell: UITableViewCell {
    
    //MARK: - Property
    private let questionInfoLabel: WSLabel = WSLabel(wsFont: .Body04)
    typealias Reactor = VoteProcessCellReactor
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupAutoLayout()
        setupAttributeds()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(questionInfoLabel)
    }
    
    private func setupAutoLayout() {
        
        self.do {
            $0.backgroundColor = .clear
        }
        
        questionInfoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(18)
        }
        
        contentView.do {
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
        }
    }
    
    private func setupAttributeds() {
        //TODO: 테스트 코드
        questionInfoLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
            $0.text = "모르는 게 생기면 물어보고 싶은 친구"
        }
    }
    
    private func updateContentLayout(isSelected: Bool) {
        contentView.backgroundColor = isSelected ? DesignSystemAsset.Colors.primary300.color.withAlphaComponent(0.15) :         DesignSystemAsset.Colors.gray700.color
        contentView.layer.borderColor = isSelected ? DesignSystemAsset.Colors.primary300.color.cgColor : UIColor.clear.cgColor
        contentView.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        updateContentLayout(isSelected: selected)
    }
}


extension VoteProcessTableViewCell: ReactorKit.View {
    func bind(reactor: VoteProcessCellReactor) {
        reactor.state
            .map { $0.content }
            .distinctUntilChanged()
            .bind(to: questionInfoLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
