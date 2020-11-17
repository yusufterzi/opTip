//
//  ViewController.swift
//  OpTip
//
//  Created by yusuf terzi on 8.11.2020.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var peopleView: UIView!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var peopleLabel: UITextField!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var tipButtonView1: UIView!
    @IBOutlet weak var tipButtonView2: UIView!
    @IBOutlet weak var tipButtonView3: UIView!
    @IBOutlet weak var tipButtonView4: UIView!
    @IBOutlet weak var tipButtonView5: UIView!

    @IBOutlet weak var customTipRateText: UITextField!
    
    var selectedTipRatio: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTipRateText.isHidden = true
        tipView.layer.cornerRadius = 10
        peopleView.layer.cornerRadius = 10
        calculateButton.layer.cornerRadius = 10
        //navigationController?.navigationBar.prefersLargeTitles = true
        setTitle()
        let menu = UIBarButtonItem(image: UIImage(named: "more"),
                                          style: UIBarButtonItem.Style.plain ,
                                          target: self, action: #selector(menuPageClicked))
        menu.image = menu.image?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = menu
        tipButtonclicked2(btn2 as Any)
    }
    
    func setTitle() {
        let label = UILabel()
        label.text = "opTip"
        label.textColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)

        label.font = UIFont(name: "NunitoSans-Bold", size: 28)
        label.textAlignment = .left
        title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    @objc func menuPageClicked() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "oldTips") as! OldItemsController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func tipMinusClicked(_ sender: Any) {
        let textValue = tipTextField.text?.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: " ", with: "")
        var iValue: Double = Double(textValue ?? "") ?? 0
        iValue -= 10
        if iValue < 0 { iValue = 0 }
        tipTextField.text = "$ " + String(format: "%.2f", iValue)
    }
    
    @IBAction func tipPlusClicked(_ sender: Any) {
        let textValue = tipTextField.text?.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: " ", with: "")
        var iValue: Double = Double(textValue ?? "") ?? 0
        iValue += 10
        tipTextField.text = "$ " + String(format: "%.2f", iValue)
    }
    
    @IBAction func editDidBegin(_ sender: Any) {
        tipTextField.text = tipTextField.text?.replacingOccurrences(of: "$ ", with: "")
    }
    
    @IBAction func editDidEnd(_ sender: Any) {
        let textValue = tipTextField.text?.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: " ", with: "")
        let iValue: Double = Double(textValue ?? "") ?? 0
        tipTextField.text = "$ " + String(format: "%.2f", iValue)
    }
    
    @IBAction func tipButtonclicked1(_ sender: Any) {
        activateButton(btn1, index: 1)
        selectedTipRatio = Double(btn1.tag)
    }
    
    @IBAction func tipButtonclicked2(_ sender: Any) {
        activateButton(btn2, index: 2)
        selectedTipRatio = Double(btn2.tag)
    }
    
    @IBAction func tipButtonclicked3(_ sender: Any) {
        activateButton(btn3, index: 3)
        selectedTipRatio = Double(btn3.tag)
    }
    
    @IBAction func tipButtonclicked4(_ sender: Any) {
        activateButton(btn4, index: 4)
        selectedTipRatio = Double(btn4.tag)
    }
    
    @IBAction func tipButtonclicked5(_ sender: Any) {
        activateButton(btn5, index: 5)
        selectedTipRatio = Double(btn5.tag)
    }
    
    @IBAction func peopleMinusclicked(_ sender: Any) {
        let textValue = peopleLabel.text
        var iValue: Int = Int(textValue ?? "") ?? 0
        iValue -= 1
        if iValue < 1 { iValue = 1 }
        peopleLabel.text = "\(iValue)"
    }
    
    @IBAction func peoplePlusClicked(_ sender: Any) {
        let textValue = peopleLabel.text
        var iValue: Int = Int(textValue ?? "") ?? 0
        iValue += 1
        peopleLabel.text = "\(iValue)"
    }

    @IBAction func tapclicked(_ sender: Any) {
        view.endEditing(true)
    }
    
}

