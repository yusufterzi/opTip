//
//  OldTipModel.swift
//  OpTip
//
//  Created by yusuf terzi on 13.11.2020.
//

import Foundation

struct OldTipModel: Codable {
    let personCount: Int
    let ratio: Double
    let date: String
    let bill: Double
    let tipAmount: Double
    let totalPerPerson: Double
}
