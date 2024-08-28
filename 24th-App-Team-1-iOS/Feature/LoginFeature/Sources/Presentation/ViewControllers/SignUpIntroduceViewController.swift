//
//  SignUpIntroduceViewController.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/28/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class SignUpIntroduceViewController: BaseViewController<SignUpInfoBottomSheetViewReactor> {

    //MARK: - Properties
    private let introduceLabel: WSLabel = WSLabel(wsFont: .Header01)
    private let introduceTextField: WSTextField = WSTextField(placeholder: "안녕 나는 1반의 비타민")
    private let confirmButton: WSButton = WSButton(wsButtonType: .default(12))
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        view.addSubviews(introduceLabel, introduceTextField)
        
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        introduceTextField.snp.makeConstraints {
            $0.top.equalTo(introduceLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        confirmButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.bottom).offset(12)
        }
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        navigationBar.do {
            $0.setNavigationBarUI(property: .all(
                DesignSystemAsset.Images.arrow.image,
                "닫기",
                "",
                DesignSystemAsset.Colors.gray300.color
            ))
            $0.setNavigationBarAutoLayout(property: .all)
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
    }
}
