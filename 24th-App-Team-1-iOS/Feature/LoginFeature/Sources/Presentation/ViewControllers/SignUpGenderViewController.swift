//
//  SignUpGenderViewController.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class SignUpGenderViewController: BaseViewController<SignUpGenderViewReactor> {

    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Header01, text: "성별")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "회원가입 이후에는 이름을 변경할 수 없어요")
    private let boyCardButton = GenderCardButton(type: .boy)
    private let girlCardButton = GenderCardButton(type: .girl)
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(titleLabel, subTitleLabel, boyCardButton, girlCardButton)
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        boyCardButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.leading.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(26)
            $0.width.equalTo(152)
            $0.height.equalTo(180)
        }
        girlCardButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(boyCardButton.snp.trailing).offset(20)
            $0.trailing.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(26)
            $0.width.equalTo(152)
            $0.height.equalTo(180)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        navigationBar
            .setNavigationBarUI(property: .leftWithCenterItem(DesignSystemAsset.Images.arrow.image, "회원가입"))
            .setNavigationBarAutoLayout(property: .leftWithCenterItem)
        
        titleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        subTitleLabel.textColor = DesignSystemAsset.Colors.gray400.color // 디쟈너 쪽에 물어보기
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        boyCardButton.rx.tap
            .bind(with: self) { owner, _ in
                let signUpNameViewReactor = SignUpNameViewReactor()
                let signUpNameViewController = SignUpNameViewController(reactor: signUpNameViewReactor)
                owner.navigationController?.pushViewController(signUpNameViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        girlCardButton.rx.tap
            .bind(with: self) { owner, _ in
                let signUpNameViewReactor = SignUpNameViewReactor()
                let signUpNameViewController = SignUpNameViewController(reactor: signUpNameViewReactor)
                owner.navigationController?.pushViewController(signUpNameViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
