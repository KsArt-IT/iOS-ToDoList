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

        // подготавливаем ячейку
        var configuration = UIListContentConfiguration.cell()
        configuration.text = AppModel.get(indexPath.row)

        cell.contentConfiguration = configuration

        return cell
    }

    // показывает кнопки с лева, когда свайпим в право
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // кнопки действий
        let action = UIContextualAction(style: .normal, title: "Rename") { _, _, completed in
            AppModel.rename(indexPath.row, "new value")

            // обновить строку
            tableView.reloadRows(at: [indexPath], with: .automatic)
            // скрыть кнопку после
            completed(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

    // показывает кнопки с права, когда свайпим в лево
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // кнопки действий
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, completed in
            AppModel.remove(indexPath.row)

            // обновить строку
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // скрыть кнопку после
            completed(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
}
