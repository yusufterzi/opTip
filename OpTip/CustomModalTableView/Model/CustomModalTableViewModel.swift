//
//  CustomModalTableViewModel.swift
//  GRAiTS
//
//  Created by yusuf terzi on 21.10.2020.
//  Copyright © 2020 Raxar Corporation. All rights reserved.
//

import UIKit

enum CustomModalTableViewStates: Equatable {
    case big(_ height: Float)
    case minimal(_ height: Float)
    case middle(_ height: Float)

    var height: CGFloat {
        switch self {
        case .big(let height):
            return CGFloat(height)
        case .minimal(let height):
            return CGFloat(height)
        case .middle(let height):
            return CGFloat(height)
        }
    }
}

class CustomModalTableViewModel {
    var hasGrayEffect: Bool = true
    var hasShadow: Bool = false
    var hasTitle: Bool = false
    var hasCloseButton: Bool = false
    var closeDisabled: Bool = false
    var state: CustomModalTableViewStates = .big(300)
    var bigState: CustomModalTableViewStates = .big(500)
    var middleState: CustomModalTableViewStates = .middle(500)
    var minimalState: CustomModalTableViewStates = .minimal(250)
    var originalHeight: CGFloat {
        return state.height
    }
    var hasMoreState: Bool = false
    var panViewHeight: CGFloat {
        return hasTitle ? CGFloat(60) : CGFloat(20)
    }
    
    var items: [TipItemModel] = .init()
    
    var imageShareHandler: ((UIImage) -> Void)?
}
