//
//  ViewController.swift
//  Calculate-App-iOS
//
//  Created by Иосиф Дзеранов on 02/05/2017.
//  Copyright © 2017 Иосиф Дзеранов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK Outlets
    @IBOutlet weak var textField: UILabel!
    
    // MARK Actions
    @IBAction func TouchButton(_ sender: UIButton) {
        
        print("touch button \(sender.tag)")
        
        //button "C" - clear textField
        if sender.tag == -1 {
            textField.text = ""
        }
        else {
            textField.text = textField.text!  +  "\(sender.currentTitle!)"
        }
    }

}

