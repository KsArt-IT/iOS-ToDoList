//
//  ListController.swift
//  ToDoList
//
//  Created by KsArT on 08.06.2024.
//

import UIKit

final class ListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addToDoAction(_ sender: Any) {
        TextPicker().show(in: self, placeholder: "New to-do list entry") { [weak self] text in
            AppModel.shared.add(title: text)

            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AppModel.shared.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let item = AppModel.shared.get(indexPath.row) {

            // подготавливаем ячейку
            var configuration = UIListContentConfiguration.cell()
            // название
            configuration.text = item.title
            // дата
            configuration.secondaryText = item.date.formatted(date: .numeric, time: .shortened)

            cell.contentConfiguration = configuration

            // отмечать галкой выполненные
            cell.accessoryType = item.isCompleted ? .checkmark : .none
        }
        return cell
    }

    // показывает кнопки с лева, когда свайпим в право
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // кнопки действий
        let action = UIContextualAction(style: .normal, title: "Rename") { _, _, completed in
            TextPicker().show(in: self, text: AppModel.shared.get(indexPath.row)?.title ?? "",
                    dismiss: {
                        // скрыть кнопку после
                        completed(true)
                    }
            ) { [weak self] text in
                AppModel.shared.rename(at: indexPath.row, title: text)

                // обновить строку
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

    // показывает кнопки с права, когда свайпим в лево
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // кнопки действий
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, completed in
            AppModel.shared.remove(at: indexPath.row)

            // удалить строку
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // скрыть кнопку после
            completed(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppModel.shared.toggle(at: indexPath.row)

        // обновить строку
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
