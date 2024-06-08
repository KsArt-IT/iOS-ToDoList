//
//  ToDoModel.swift
//  ToDoList
//
//  Created by KsArT on 08.06.2024.
//

import Foundation

class AppModel {
    private static var todolist: [String] = ["To do 1", "To do 2", "To do 3", "To do 4"]
    static var count: Int {
        todolist.count
    }

    static func add(_ text: String) {
        guard !text.isEmpty else { return }

        todolist.append(text)
    }

    static func del() {

    }

    static func get(_ index: Int) -> String {
        guard case 0..<todolist.endIndex = index else { return "" }

        return todolist[index]
    }
}
