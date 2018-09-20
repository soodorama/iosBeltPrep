//
//  AddEditVC.swift
//  iosBeltPrep
//
//  Created by Neil Sood on 9/19/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

protocol AddEditVCDelegate: class {
    func dosomething()
}

class AddEditVC: UIViewController {

    weak var delegate: AddEditVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("whhhhhhaaaat")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
