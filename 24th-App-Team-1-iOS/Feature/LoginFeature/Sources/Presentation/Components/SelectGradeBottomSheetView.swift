//
//  SelectClassViewController.swift
//  LoginFeature
//
//  Created by eunseou on 7/14/24.
//

import UIKit
import Util
import DesignSystem

import Then
import SnapKit

public final class SelectGradeBottomSheetView: UIView {

    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Body01, text: "현재 학년을 선택해주세요")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "만 14세 미만 학생은 가입이 어려워요")
    public let firstGradeButton = SelectGradeView(grade: .first)
    public let secondGradeButton = SelectGradeView(grade: .second)
    public let thirdGradeButton = SelectGradeView(grade: .third)
    
    //MARK: - Initializer
    public init() {
        super.init(frame: .zero)
        
        setupUI()
        setupAutoLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        

    //MARK: - Functions
    public func setupUI() {
        
        addSubviews(titleLabel, subTitleLabel, firstGradeButton, secondGradeButton, thirdGradeButton)
    }
    
    public func setupAutoLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        firstGradeButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(40)
        }
        secondGradeButton.snp.makeConstraints {
            $0.top.equalTo(firstGradeButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.height.equalTo(40)
        }
        thirdGradeButton.snp.makeConstraints {
            $0.top.equalTo(secondGradeButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(40)
        }
    }
    
    public func setupAttributes() {
        
        backgroundColor = DesignSystemAsset.Colors.gray600.color
        
        titleLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
        subTitleLabel.textColor = DesignSystemAsset.Colors.gray300.color
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    

}
