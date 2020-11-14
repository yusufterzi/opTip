//
//  TipCalculateView.swift
//  OpTip
//
//  Created by yusuf terzi on 10.11.2020.
//

import UIKit

class TipCalculateView: CustomModalTableView {

    init(controller: UIViewController) {
        super.init(frame: CGRect())
        
        let tabBarHeight = controller.tabBarController?.tabBar.frame.size.height ?? 0
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(self)
        bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: tabBarHeight * -1).isActive = true
        rightAnchor.constraint(equalTo: controller.view.rightAnchor, constant: 0).isActive = true
        leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: 0).isActive = true
        viewModel.state = .big(350)
        
        loadUI(baseController: controller)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
