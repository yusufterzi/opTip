//
//  OldItemsController.swift
//  OpTip
//
//  Created by yusuf terzi on 13.11.2020.
//

import UIKit

class OldItemsController: UIViewController {
    var oldItemsArray: [OldTipModel] = .init()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        if let data = UserDefaults.standard.value(forKey:"oldItems") as? Data {
            oldItemsArray = (try? PropertyListDecoder().decode(Array<OldTipModel>.self, from: data)) ?? .init()
        }
        tableView.register(UINib(nibName: "OldItemCell", bundle: nil), forCellReuseIdentifier: "OldItemCell")

        let backButton = UIBarButtonItem(image: UIImage(named: "arrow-left")?.withRenderingMode(.alwaysOriginal),
                        style: .plain, target: self, action:  #selector(backClicked))
        let label = UILabel()
        label.text = "Tip History"
        label.textColor = UIColor(red: 0.221, green: 0.221, blue: 0.221, alpha: 1)

        label.font = UIFont(name: "NunitoSans-Bold", size: 28)
        label.textAlignment = .left
        title = ""
        let titleView = UIBarButtonItem.init(customView: label)
        
        navigationItem.leftBarButtonItems = [backButton, titleView]
    }
    
    @objc func backClicked() {
        navigationController?.popViewController(animated: true)
    }

}

extension OldItemsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        oldItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OldItemCell", for: indexPath) as! OldItemCell
        let item = oldItemsArray[indexPath.row]
        cell.populate(item: item)
        return cell
    }
    
    
}
