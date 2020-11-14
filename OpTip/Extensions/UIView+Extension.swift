//
//  UIView+Extension.swift
//  OpTip
//
//  Created by yusuf terzi on 13.11.2020.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
