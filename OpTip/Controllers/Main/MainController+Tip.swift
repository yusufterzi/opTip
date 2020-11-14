//
//  MainController+Tip.swift
//  OpTip
//
//  Created by yusuf terzi on 14.11.2020.
//

import UIKit

extension MainController {
    func resetAllButtons() {
        customTipRateText.isHidden = true
        customTipRateText.text = ""
        btn5.isHidden = false
        resetButton(btn1)
        resetButton(btn2)
        resetButton(btn3)
        resetButton(btn4)
        resetButton(btn5)
    }
    
    func resetButton(_ btn: UIButton) {
        btn.titleLabel?.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        btn.setTitleColor(UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1), for: .normal)
    }
    
    func activateButton(_ btn: UIButton, index: Int) {
        resetAllButtons()
        btn.titleLabel?.font = UIFont(name: "NunitoSans-Bold", size: 16)
        btn.setTitleColor(UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1), for: .normal)
        
        tipButtonView1.isHidden = true
        tipButtonView2.isHidden = true
        tipButtonView3.isHidden = true
        tipButtonView4.isHidden = true
        tipButtonView5.isHidden = true
        
        switch index {
        case 1:
            tipButtonView1.isHidden = false
        case 2:
            tipButtonView2.isHidden = false
        case 3:
            tipButtonView3.isHidden = false
        case 4:
            tipButtonView4.isHidden = false
        case 5:
            tipButtonView5.isHidden = false
            customTipRateText.text = "%"
            customTipRateText.isHidden = false
            customTipRateText.becomeFirstResponder()
            btn5.isHidden = true
        default:
            break
        }
    }
    
    @IBAction func btnCalculateClicked(_ sender: Any) {
        if selectedTipRatio <= 0 {
            return

        }
        let billText = tipTextField.text?.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: " ", with: "")
        let billValue: Double = Double(billText ?? "") ?? 0
        
        let personText = peopleLabel.text
        let personCount: Int = Int(personText ?? "") ?? 0
        
        let totalTip: Double = billValue / 100.0 * Double(selectedTipRatio)
        let tipPerPerson: Double = totalTip / Double(personCount)
        
        let tipView = TipCalculateView(controller: self)
        var tipItem: TipItemModel = TipItemModel()
        tipItem.title = "Tip Amount"
        tipItem.value = "$" + String(format: "%.2f", totalTip)
        tipView.viewModel.items.append(tipItem)
        
        tipItem = TipItemModel()
        tipItem.title = "Tip Per Person"
        tipItem.value = "$" + String(format: "%.2f", tipPerPerson)
        tipView.viewModel.items.append(tipItem)
        
        tipItem = TipItemModel()
        tipItem.title = "Total Per Person"
        tipItem.value = "$" + String(format: "%.2f", (totalTip + Double(billValue)) / Double(personCount))
        tipView.viewModel.items.append(tipItem)
        
        tipItem = TipItemModel()
        tipItem.title = ""
        tipView.viewModel.items.append(tipItem)
        
        tipItem = TipItemModel()
        tipItem.title = "Total Bill"
        tipItem.value = "$" + String(format: "%.2f", (Double(billValue) + totalTip))
        tipItem.titleColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)
        tipItem.titleFont = UIFont(name: "NunitoSans-Bold", size: 16)
        tipItem.valueColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        tipItem.valueFont = UIFont(name: "NunitoSans-Bold", size: 16)
        tipView.viewModel.items.append(tipItem)
        
        tipView.tableView.reloadData()
        
        tipView.viewModel.imageShareHandler = { [weak self] image in
            guard let self = self else { return }
            let imageShare = [image]
            let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
        
        var oldItems: [OldTipModel]?
        if let data = UserDefaults.standard.value(forKey:"oldItems") as? Data {
            oldItems = try? PropertyListDecoder().decode(Array<OldTipModel>.self, from: data)
        }
        if oldItems == nil {
            oldItems = .init()
        }
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        let now = df.string(from: Date())
        let item: OldTipModel = OldTipModel(
            personCount: personCount,
            ratio: self.selectedTipRatio, date: now,
            bill: billValue, tipAmount: totalTip,
            totalPerPerson: (totalTip + Double(billValue)) / Double(personCount))
        oldItems?.append(item)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(oldItems), forKey:"oldItems")
    }
    
    @IBAction func tipRateTextChanged(_ sender: Any) {
        if customTipRateText.text == "" {
            customTipRateText.text = "%"
        }
        let ratioText = customTipRateText.text?.replacingOccurrences(of: "%", with: "").replacingOccurrences(of: " ", with: "")
        selectedTipRatio = Double(ratioText ?? "") ?? 0.0
    }
}
