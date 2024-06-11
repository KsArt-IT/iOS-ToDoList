//
//  ToDoModel.swift
//  ToDoList
//
//  Created by KsArT on 08.06.2024.
//

import Foundation

class AppModel {
    static let shared = AppModel()

    private var todolist: [ToDoItem] = []

    var count: Int {
        todolist.count
    }

    private init() {
        load()
    }

    // MARK: - Обработка списка
    func get(_ index: Int) -> ToDoItem? {
        guard case 0..<todolist.endIndex = index else { return nil }

        return todolist[index]
    }

    func add(title: String) {
        guard !title.isEmpty else { return }

        todolist.append(ToDoItem(title: title, date: Date(), isCompleted: false))
        save()
    }

    func remove(at index: Int) {
        guard case 0..<todolist.endIndex = index else { return }

        todolist.remove(at: index)
        save()
    }

    func rename(at index: Int, title: String) {
        guard case 0..<todolist.endIndex = index else { return }
        guard !title.isEmpty else { return }

        change(at: index,title: title)
    }

    func toggle(at index: Int) {
        guard case 0..<todolist.endIndex = index else { return }

        change(at: index, isCompleted: !todolist[index].isCompleted)
    }

    private func change(at index: Int, title: String? = nil, date: Date? = nil, isCompleted: Bool? = nil) {
        let oldItem = todolist[index]
        todolist[index] = ToDoItem(
            title: title ?? oldItem.title,
            date: date ?? oldItem.date,
            isCompleted: isCompleted ?? oldItem.isCompleted
        )
        save()
    }

    // MARK: - Сохранение и загрузка списка
    private func save() {
        // кодируем данные и сохраняем
        if let data = try? PropertyListEncoder().encode(todolist) {
            UserDefaults.standard.setValue(data, forKey: "todolist")
        }
    }

    private func load() {
        // загружаем и декодируем
        if let data = UserDefaults.standard.object(forKey: "todolist") as? Data {
            todolist = (try? PropertyListDecoder().decode([ToDoItem].self, from: data)) ?? []
        }
    }

}

// MARK: - Елемент списка
struct ToDoItem: Codable {
    let title: String
    let date: Date
    let isCompleted: Bool
}
