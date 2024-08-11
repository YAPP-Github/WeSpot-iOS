//
//  AllMainViewController.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/11/24.
//

import DesignSystem
import UIKit
import Util

import Then
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class AllMainViewController: BaseViewController<AllMainViewReactor> {

    //MARK: - Properties
    private let profileContainerView: UIView = UIView()
    private let profileImageView: UIView = UIView()
    private let profileNameLabel: WSLabel = WSLabel(wsFont: .Body02)
    private let profileClassLabel: WSLabel = WSLabel(wsFont: .Body06)
    private let profilEditButton: WSButton = WSButton(wsButtonType: .secondaryButton)
//    private let voteAddBaner: WSBanner = WSBanner(image: <#T##UIImage?#>, titleText: <#T##String#>, subText: <#T##String?#>)
    
    //MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Configure
    public override func setupUI() {
        super.setupUI()
        
    }
    
    public override func setupAutoLayout() {
        super.setupAutoLayout()
        
    }
    
    public override func setupAttributes() {
        super.setupAttributes()
        
    }
    
    public override func bind(reactor: Reactor) {
        super.bind(reactor: reactor)
        
    }
}
