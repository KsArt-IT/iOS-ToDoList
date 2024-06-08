//
//  ListController.swift
//  ToDoList
//
//  Created by KsArT on 08.06.2024.
//

import UIKit

class ListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addToDoAction(_ sender: Any) {
        AppModel.add("New \(AppModel.count + 1)")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AppModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        var configuration = UIListContentConfiguration.cell()
        configuration.text = AppModel.get(indexPath.row)

        cell.contentConfiguration = configuration

        return cell
    }

}
