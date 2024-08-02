//
//  SignUpSchoolViewController.swift
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
import RxDataSources
import ReactorKit

public final class SignUpSchoolViewController: BaseViewController<SignUpSchoolViewReactor> {
    
    //MARK: - Properties
    private let titleLabel = WSLabel(wsFont: .Header01, text: "학교 검색")
    private let subTitleLabel = WSLabel(wsFont: .Body06, text: "현재 재학 중인 학교 기준으로 검색해 주세요")
    private let schoolTextField = WSTextField(state: .withLeftItem(DesignSystemAsset.Images.magnifyingglass.image), placeholder: "학교 이름으로 검색해 주세요")
    private let warningLabel = WSLabel(wsFont: .Body07, text: "20자 이내로 검색해 주세요")
    private let additionalButton = UIButton()
    private let additionalButtonLine = UIView()
    private let schoolSearchTableView = UITableView()
    private let gradientView = GradientView()
    private let nextButton = WSButton(wsButtonType: .default(12))
    private lazy var schoolSearchTableViewDataSource = RxTableViewSectionedReloadDataSource<SchoolSection>(configureCell: { (dataSource, tableView, indexPath, item) in
        let cell = tableView.dequeueReusableCell(withIdentifier: SchoolSearchTableViewCell.identifier, for: indexPath) as! SchoolSearchTableViewCell
        cell.selectionStyle = .none
        cell.setupCell(schoolName: item.school.name, address: item.school.address)
        return cell
    })
    
    //MARK: - LifeCycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        schoolTextField.becomeFirstResponder()
        warningLabel.isHidden = true
        hideKeyboard()
    }
    
    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
        view.addSubviews(titleLabel, subTitleLabel, schoolTextField, warningLabel, additionalButton,
                         additionalButtonLine, schoolSearchTableView, gradientView, nextButton)
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
        schoolTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(schoolTextField.snp.bottom).offset(4)
            $0.leading.equalTo(schoolTextField.snp.leading).offset(10)
        }
        additionalButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(21)
            $0.top.equalTo(schoolTextField.snp.bottom).offset(24)
        }
        additionalButtonLine.snp.makeConstraints {
            $0.top.equalTo(additionalButton.snp.bottom)
            $0.height.equalTo(1)
            $0.horizontalEdges.equalTo(additionalButton.snp.horizontalEdges)
        }
        schoolSearchTableView.snp.makeConstraints {
            $0.top.equalTo(schoolTextField.snp.bottom).offset(24)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-44)
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-12)
        }
        gradientView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(nextButton.snp.bottom).offset(12)
            $0.height.equalTo(110)
        }
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
        view.backgroundColor = DesignSystemAsset.Colors.gray900.color
        
        navigationBar
            .setNavigationBarUI(property: .leftWithCenterItem(DesignSystemAsset.Images.arrow.image, "회원가입"))
            .setNavigationBarAutoLayout(property: .leftWithCenterItem)
        
        titleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray100.color
        }
        
        subTitleLabel.do {
            $0.textColor = DesignSystemAsset.Colors.gray400.color
        }
        
        warningLabel.do {
            $0.textColor = DesignSystemAsset.Colors.destructive.color
        }
        
        additionalButton.do {
            $0.setTitle("찾는 학교가 없다면?", for: .normal)
            $0.setTitleColor(DesignSystemAsset.Colors.gray300.color, for: .normal)
            $0.titleLabel?.font = WSFont.Body05.font()
        }
        
        additionalButtonLine.do {
            $0.backgroundColor = DesignSystemAsset.Colors.gray300.color
        }
        
        schoolSearchTableView.do {
            $0.register(SchoolSearchTableViewCell.self, forCellReuseIdentifier: SchoolSearchTableViewCell.identifier)
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.rowHeight = 104
        }
        
        nextButton.do {
            $0.setupButton(text: "다음")
            $0.isEnabled = false
        }
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
        schoolTextField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .map { self.schoolTextField.isEditing }
            .bind(to: schoolTextField.borderUpdateBinder )
            .disposed(by: disposeBag)
        
        schoolTextField.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { Reactor.Action.searchSchool($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$schoolList)
            .map { [SchoolSection.schoolInfo($0.schools.map(SchoolItem.init))] }
            .bind(to: schoolSearchTableView.rx.items(dataSource: schoolSearchTableViewDataSource))
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.schoolName.isEmpty || (!$0.schoolName.isEmpty && $0.schoolList.schools.count > 0)}
            .distinctUntilChanged()
            .bind(to: additionalButton.rx.isHidden, additionalButtonLine.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.schoolName.count <= 20 }
            .distinctUntilChanged()
            .bind(to: warningLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        nextButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                let signUpGradeViewReactor = SignUpGradeViewReactor()
                let signUpGradeViewController = SignUpGradeViewController(reactor: signUpGradeViewReactor)
                owner.navigationController?.pushViewController(signUpGradeViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
