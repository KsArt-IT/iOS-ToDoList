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

    private init() {}

    func add(title: String) {
        guard !title.isEmpty else { return }

        todolist.append(ToDoItem(title: title, date: Date(), isCompleted: false))
    }

    func remove(at index: Int) {
        guard case 0..<todolist.endIndex = index else { return }

        todolist.remove(at: index)
    }

    func rename(at index: Int, title: String) {
        guard case 0..<todolist.endIndex = index else { return }
        guard !title.isEmpty else { return }

        change(at: index,title: title)
    }

    func get(_ index: Int) -> ToDoItem? {
        guard case 0..<todolist.endIndex = index else { return nil }

        return todolist[index]
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
    }
}

struct ToDoItem: Codable {
    let title: String
    let date: Date
    let isCompleted: Bool
}
