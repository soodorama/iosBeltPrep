//
//  AddEditVC.swift
//  iosBeltPrep
//
//  Created by Neil Sood on 9/19/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

protocol AddEditVCDelegate: class {
    func cancelPressed()
    func savePressed(data: [String:Any], indexPath:IndexPath?)
}

class AddEditVC: UIViewController {

    weak var delegate: AddEditVCDelegate?
    var data = [String:Any]()
    var indexPath: IndexPath?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = data["title"] as? String
        descField.text = data["desc"] as? String
        datePicker.date = data["date"] as! Date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelPressed()
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        data["title"] = titleField.text
        data["desc"] = descField.text
        data["date"] = datePicker.date
        delegate?.savePressed(data: data, indexPath: indexPath)
    }
    
    
}
