//
//  ViewController.swift
//  Calculate-App-iOS
//
//  Created by Иосиф Дзеранов on 02/05/2017.
//  Copyright © 2017 Иосиф Дзеранов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var digits:[Int]!, operators:[String]!, temp:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        digits = [Int]()
        operators = [String]()
        temp = String()
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
            digits.removeAll()
            operators.removeAll()
            temp.removeAll()
        }
        else {
            let typeButton:String = sender.currentTitle!
            textField.text = textField.text!  +  "\(typeButton)"
            switch typeButton {
            case "x", "/", "+", "-":
                digits.append(Int(temp)!)
                operators.append(typeButton)
                temp.removeAll()
            case "=":
                digits.append(Int(temp)!)
                let resultOperation:Int = ExecuteOperations()
                textField.text = textField.text!  +  "\(resultOperation)"
                
            default:
                temp = temp + typeButton
            }
        }
        print(temp)
        print("digits сontains \(digits)")
        print("Operators contains \(operators)")
        
    }
    @IBAction func SaveData(_ sender: Any) {
        SaveDataToLocalStorage(value: textField.text!, keyValue: GetDate())
        print("Saved data of this kind: \(GetDate()) - \(textField.text!) ")
    }
    
    func ExecuteOperations()-> Int{
        var previosResult:Int = digits[0]
        let countElementsCounts = digits.count
        for index in 1 ..< countElementsCounts{
            print(index)
            let operation : String = operators[index-1]
            let operand : Int = digits[index]
            switch operation {
            case "+":
                previosResult += operand
            case "-":
                previosResult -= operand
            case "x":
                previosResult *= operand
            default:
                previosResult /= operand
            }
        }
        return previosResult
    }
    func GetDate()->String{
        let date = Date().timeIntervalSince1970
        return String(date)
    }
    
    func SaveDataToLocalStorage(value: String, keyValue: String)-> (){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: keyValue)
        return
    }

}

