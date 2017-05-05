//
//  ViewController.swift
//  Calculate-App-iOS
//
//  Created by Иосиф Дзеранов on 02/05/2017.
//  Copyright © 2017 Иосиф Дзеранов. All rights reserved.
//

import UIKit
/*
class DataCalculator: NSObject, NSCoding {
    var date : Double
    var text: String
    
    init(date: Double, text: String) {
        self.date = date
        self.text = text
    }
    
    required convenience init(coder decoder: NSCoder) {
        let text = decoder.decodeObject(forKey: "text") as! String
        let date = decoder.decodeObject(forKey: "name") as! Double
        self.init(date: date, text: text)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(text, forKey: "text")
    }
}
*/

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
        
        SaveDataToLocalStorage(value: textField.text!)
        textField.text = String()
    }
    
    func ExecuteOperations()-> Int {
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
  
    func GetDate()->Date{
        let date = Date()
        print("Get date today ->", date)
        return date
    }
    
    func SaveDataToLocalStorage(value: String)-> (){
        
        let defaultKeyDate = "date", defaultKeyText =  "text"
        
        let defaults = UserDefaults.standard
        
        let arrayText = defaults.object(forKey: defaultKeyText)
        print("ArrayData return value ->", arrayText ?? "nil")
        
        if var array = arrayText as? [String] {
            debugPrint("array: ", array)
            array.append(value)
            
            defaults.set(array, forKey: defaultKeyText)
            defaults.synchronize()
        }
        else {
            var newArray = [String]()
            newArray.append(value)
            defaults.set(newArray, forKey: defaultKeyText)
            defaults.synchronize()
        }
       
    }
    
    
    
    
}

