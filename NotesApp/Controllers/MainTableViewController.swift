//
//  ViewController.swift
//  NotesApp
//
//  Created by Américo MQ on 25/02/22.
//

import UIKit

class MainTableViewController: UITableViewController {

    @IBOutlet var mainTableView: UITableView!
    
    var categoryNotes = ["Category Note one","Category Note two","Category Note three","Category Note Four"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categoryNotes[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NoteList") else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

}

