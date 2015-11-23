import Foundation
import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var cipherPicker: UIPickerView!
    @IBOutlet var attackPicker: UIPickerView!
    @IBOutlet var chosenLanguageLabel: UILabel!
    
    var chosenCipher: Int = 0
    var chosenAttack: Int = 0
    var cipherData = []
    var attackData = []

    
    override func viewDidLoad() {
        cipherData = Storage.availableCiphers()
        attackData = Storage.availableAttacks()
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        // set chosen cipher in pickerview
        if let cipher = userDefaults.objectForKey("cipher") {
            chosenCipher = cipher as! Int
            cipherPicker.selectRow(chosenCipher, inComponent: 0, animated: false)
        }
        // set chosen attack in pickerview
        if let attack = userDefaults.objectForKey("attack") {
            chosenAttack = attack as! Int
            attackPicker.selectRow(attack as! Int, inComponent: 0, animated: false)
        }
        // set label of chosen language
        if let lang = userDefaults.stringForKey("language") {
            chosenLanguageLabel.text = lang
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        updateLanguageLabel()
        
        // print("SettingsController:\n  chosenCipher: \(chosenCipher)\n  chosenAttack: \(chosenAttack)\n  cipherData: \(cipherData)\n  attackData: \(attackData) ")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateLanguageLabel() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let lang = userDefaults.stringForKey("language") {
            chosenLanguageLabel.text = lang
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Picker views - tag 0 = cipherPicker, tag 1 = attackPicker
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if pickerView.tag == 0 {
            // set chosen cipher
            chosenCipher = row
            chosenAttack = 0
            
            attackPicker.reloadAllComponents()
            attackPicker.selectRow(chosenAttack, inComponent: 0, animated: false)
            
            userDefaults.setInteger(row, forKey: "cipher")
            userDefaults.setInteger(0, forKey: "attack")
        }
        else if pickerView.tag == 1 {
            // set chosen attack method
            chosenAttack = row
            
            userDefaults.setInteger(row, forKey: "attack")
        }
        
        userDefaults.synchronize()
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return cipherData.count
        } else {
            return attackData[chosenCipher].count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return cipherData[row] as? String
        } else {
            return attackData[chosenCipher][row] as? String
        }
        
    }
    
    
}
