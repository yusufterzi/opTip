//
//  CustomModalTableView+TableView.swift
//  OpTip
//
//  Created by yusuf terzi on 10.11.2020.
//

import UIKit

extension CustomModalTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tipItem = viewModel.items[indexPath.row]
        if (tipItem.title ?? "").isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LineCell", for: indexPath) as! LineCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TipItemCell", for: indexPath) as! TipItemCell
            cell.loadData(item: tipItem)
            return cell
        }
    }
    
}
