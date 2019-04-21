//
//  SecondViewController.swift
//  IceCube
//
//  Created by Bryan Richard on 20/02/2019.
//  Copyright © 2019 Bryan Richard. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  
    
    var myName: String = ""
    
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Label.text = myName
       
    }
    

    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            Label.text = "FIRST"
            Label.isHidden = false
        case 1:
            Label.isHidden = true
        default: break
        }
    }
    
    
}
