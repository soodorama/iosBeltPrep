//
//  ViewVC.swift
//  iosBeltPrep
//
//  Created by Neil Sood on 9/19/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

protocol ViewVCDelegate: class {
    func backPressed()
}

class ViewVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var delegate: ViewVCDelegate?
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = note?.title
        descLabel.text = note?.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateLabel.text = dateFormatter.string(from: (note?.date)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        delegate?.backPressed()
    }
}
