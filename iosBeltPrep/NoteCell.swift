//
//  NoteCell.swift
//  iosBeltPrep
//
//  Created by Neil Sood on 9/19/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var checkedButton: UIButton!
    @IBOutlet weak var noteLabel: UILabel!
    
    var indexPath: IndexPath?
    
    @IBAction func checkedPressed(_ sender: UIButton) {
        if checkedButton.backgroundImage(for: .normal) == UIImage(named: "circle_empty") {
            let image = UIImage(named: "circle_full")
            checkedButton.setBackgroundImage(image, for: .normal)
        }
        else {
            let image = UIImage(named: "circle_empty")
            checkedButton.setBackgroundImage(image, for: .normal)
        }
    }
}
