//
//  EntryDetailViewController.swift
//  JournalCoreData
//
//  Created by stanley phillips on 1/18/21.
//

import UIKit

class EntryDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    // MARK: - Properties
    var entry: Entry?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func clearTextButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let bodyText = bodyTextView.text else {return}
        
        if let entry = entry {
            EntryController.shared.update(entry: entry, title: title, bodyText: bodyText)
        } else {
            EntryController.shared.createEntryWith(title: title, bodyText: bodyText)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let entryDetails = entry else {return}
        titleTextField.text = entryDetails.title
        bodyTextView.text = entryDetails.bodyText
    }
}//end of class
