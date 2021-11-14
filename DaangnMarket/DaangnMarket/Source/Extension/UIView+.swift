//
//  UIView+.swift
//  DaangnMarket
//
//  Created by 김윤서 on 2021/11/15.
//

import UIKit.UIView

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
