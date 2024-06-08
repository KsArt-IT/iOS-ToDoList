//
//  TextPicker.swift
//  ToDoList
//
//  Created by KsArT on 08.06.2024.
//

import UIKit

final class TextPicker {

    func show(in viewController: UIViewController, placeholder: String = "", text: String = "", dismiss: @escaping () -> Void = {}, complition: @escaping (String) -> Void) {

        let allertController = UIAlertController(title: "ToDoItem", message: nil, preferredStyle: .alert)
        allertController.addTextField { textField in
            if !placeholder.isEmpty {
                textField.placeholder = placeholder
            }
            if !text.isEmpty {
                textField.text = text
            }
        }

        let okAction = UIAlertAction(title: "Ok", style: .default){ _ in
            if let text = allertController.textFields?[0].text, !text.isEmpty {
                complition(text)
                dismiss()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            dismiss()
        }

        allertController.addAction(okAction)
        allertController.addAction(cancelAction)

        viewController.present(allertController, animated: true)
    }
}
