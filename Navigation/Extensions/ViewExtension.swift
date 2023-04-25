//
//  ViewExtension.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
