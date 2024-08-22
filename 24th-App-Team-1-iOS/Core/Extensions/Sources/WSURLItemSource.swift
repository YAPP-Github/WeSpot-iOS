//
//  WSURLItemSource.swift
//  Extensions
//
//  Created by Kim dohyun on 8/21/24.
//

import UIKit

final class WSURLItemSource: NSObject, UIActivityItemSource {
    private let wespotAppURL: URL
    
    init(wespotAppURL: URL) {
        self.wespotAppURL = wespotAppURL
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return wespotAppURL
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return wespotAppURL
    }
    
}
