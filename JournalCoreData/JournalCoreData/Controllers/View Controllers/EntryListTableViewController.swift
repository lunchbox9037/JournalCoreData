//
//  EntryListTableViewController.swift
//  JournalCoreData
//
//  Created by stanley phillips on 1/18/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    // MARK: - Outlets

    // MARK: - Lifecyce Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EntryController.shared.fetchEntries()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            EntryController.shared.delete(entry: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryDetailViewController else {return}
            let entryToSend = EntryController.shared.entries[indexPath.row]
            destination.entry = entryToSend
        }
    }
}
