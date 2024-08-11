//
//  MainTableViewHeaderFooterView.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/12/24.
//

import DesignSystem
import UIKit


final class MainTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    private let separatorView: UIView = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        print("mainHeader Footer view")
        setupUI()
        setupAttributeds()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(separatorView)
    }
    
    private func setupAutoLayout() {
        separatorView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(1)
            $0.height.equalTo(1)
        }
    }
    
    private func setupAttributeds() {
        separatorView.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray700.color
        }
    }
}
