//
//  SelectClassButton.swift
//  LoginFeature
//
//  Created by eunseou on 7/14/24.
//

import UIKit
import DesignSystem

import SnapKit

final public class SelectGradeView: UIView {

    //MARK: - Properties
    public enum gradeType {
        case first
        case second
        case third
        
        var text: String {
            switch self {
            case .first:
                "1학년"
            case .second:
                "2학년"
            case .third:
                "3학년"
            }
        }
    }
    
    private let gradeLabel = WSLabel(wsFont: .Body03)
    public let checkButton = UIButton()
    
    //MARK: - Initializer
    public init(grade: gradeType) {
        super.init(frame: .zero)
        
        setupUI()
        setupAutoLayout()
        setupAttributes()
        setupGradeText(text: grade.text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Functions
    private func setupUI() {
        
        addSubviews(gradeLabel, checkButton)
    }
    
    private func setupAutoLayout() {
        
        gradeLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().offset(8)
            $0.leading.equalToSuperview()
        }
        checkButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
    
    private func setupAttributes() {
        
        gradeLabel.textColor = DesignSystemAsset.Colors.gray100.color
        
    }
    
    private func setupGradeText(text: String) {
        
        gradeLabel.text = text
        
        checkButton.setImage(DesignSystemAsset.Images.check.image, for: .normal)
        checkButton.setImage(DesignSystemAsset.Images.checkSelected.image, for: .highlighted)
    }

}
