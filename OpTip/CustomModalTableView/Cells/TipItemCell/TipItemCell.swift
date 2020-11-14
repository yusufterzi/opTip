//
//  TipItemCell.swift
//  OpTip
//
//  Created by yusuf terzi on 11.11.2020.
//

import UIKit

class TipItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func loadData(item: TipItemModel) {
        titleLabel.font = item.titleFont
        titleLabel.text = item.title
        titleLabel.textColor = item.titleColor
        
        valueLabel.font = item.valueFont
        valueLabel.text = item.value
        valueLabel.textColor = item.valueColor
    }
}
