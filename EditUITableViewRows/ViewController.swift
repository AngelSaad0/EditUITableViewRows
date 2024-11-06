//
//  ViewController.swift
//  EditUITableViewRows
//
//  Created by Engy on 11/6/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var names = ["John", "Jane", "Doe"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - UITableView DataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let data = names[indexPath.row]
        cell.textLabel?.text = data
        return cell
    }

    // MARK: - UITableView Delegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit", message: "Edit TableView Row", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
            guard let self = self ,let updatedText = alert.textFields?[0].text,
                  !updatedText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return}
            names[indexPath.row] = updatedText
            DispatchQueue.main.async {
                tableView.reloadRows(at: [indexPath], with: .fade)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            tableView.deselectRow(at: indexPath, animated: true)
            print("Cancel button tapped")
        }

        alert.addAction(updateAction)
        alert.addAction(cancelAction)

        alert.addTextField { textField in
            textField.text = self.names[indexPath.row]
            textField.placeholder = "Enter new name"
        }

        present(alert, animated: true, completion: nil)

    }
}
