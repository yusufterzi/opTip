//
//  OldItemCell.swift
//  OpTip
//
//  Created by yusuf terzi on 13.11.2020.
//

import UIKit

class OldItemCell: UITableViewCell {

    @IBOutlet private weak var viewPerson: UIView!
    @IBOutlet private weak var lblPerson: UILabel!
    @IBOutlet private weak var viewRate: UIView!
    @IBOutlet private weak var lblRate: UILabel!
    @IBOutlet private weak var viewDate: UIView!
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var lblBill: UILabel!
    @IBOutlet private weak var lblTip: UILabel!
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var lblTotalPerPerson: UILabel!
    
    func populate(item: OldTipModel) {
        selectionStyle = .none
        viewPerson.layer.cornerRadius = 12
        viewRate.layer.cornerRadius = 12
        viewDate.layer.cornerRadius = 12
                                  
        lblPerson.text = "\(item.personCount)"
        lblRate.text = "\(item.ratio)%"
        lblDate.text = item.date
        
        lblBill.text = String(format: "$%.2f", item.bill)
        lblTip.text = String(format: "$%.2f", item.tipAmount)
        lblTotalPerPerson.text = String(format: "$%.2f", item.totalPerPerson)
    }
    
    override func layoutSubviews() {
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        mainView.layer.shadowColor = UIColor(red: 0.575, green: 0.575, blue: 0.575, alpha: 0.07).cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
}
