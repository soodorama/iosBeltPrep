//
//  MainVC.swift
//  iosBeltPrep
//
//  Created by Neil Sood on 9/19/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableData: [Note] = []
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        fetchAllNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        fetchAllNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddEditSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddEditSegue" {
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! AddEditVC
            dest.delegate = self
            
            if let indexPath = sender as? IndexPath {
                dest.indexPath = indexPath
                dest.data["title"] = tableData[indexPath.row].title
                dest.data["desc"] = tableData[indexPath.row].desc
                dest.data["date"] = tableData[indexPath.row].date
                dest.indexPath = indexPath

            }
            else {
                dest.data["date"] = Date()
                dest.data["title"] = ""
                dest.data["desc"] = ""
            }
        }
        if segue.identifier == "ViewInfo" {
            let nav = segue.destination as! UINavigationController
            let destination = nav.topViewController as! ViewVC
            
            //            To show specific tasks
            let indexPath = sender as! IndexPath
            let note = tableData[indexPath.row]
            //            print("That's the task with the destination", destination.task)
            destination.note = note
        }
        
    }
    
    func fetchAllNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortTitle = NSSortDescriptor(key: "title", ascending: true)
        let sortCompleted = NSSortDescriptor(key: "complete", ascending: true)
        request.sortDescriptors = [sortTitle, sortCompleted]
        do {
            tableData = try context.fetch(request)
        }
        catch {
            print("Error to fetch all tasks")
        }
    }
    
}


extension MainVC: AddEditVCDelegate {
    func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    func savePressed(data: [String:Any], indexPath: IndexPath?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
    
        
        if let path = indexPath {
            // write over edited cell
            let note = tableData[path.row]
            note.desc = data["desc"] as? String
            note.title = data["title"] as? String
            note.date = data["date"] as? Date
            
        }
        else {
            // write new cell
            let note = Note(context: context)
            
            note.desc = data["desc"] as? String
            note.title = data["title"] as? String
            note.date = data["date"] as? Date
            note.isChecked = false
            tableData.append(note)
        }
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
        print(data["title"] as! String)
//        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.textLabel?.text = tableData[indexPath.row].title
        cell.indexPath = indexPath
        // todo: check background image of checked button
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "ViewSegue", sender: indexPath)
        }
        edit.backgroundColor = .green
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let note = self.tableData[indexPath.row]
            self.context.delete(note)
            
            do {
                try self.context.save()
            } catch {
                print("\(error)")
            }
            
            self.tableData.remove(at: indexPath.row)
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        return [edit, delete]
    }
    
    
}

extension MainVC: ViewVCDelegate {
    func backPressed() {
        dismiss(animated: true, completion: nil)
    }
}
