import Foundation
import UIKit

class EncryptionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var txtOpenText: UITextView!
    @IBOutlet var txtCodedText: UITextView!
    @IBOutlet var txtKey: UITextField!
    @IBOutlet var randomKeyButton: UIButton!
    @IBOutlet var encryptButton: UIButton!
    @IBOutlet var decryptButton: UIButton!
    @IBOutlet var keyView: UIImageView!
    @IBOutlet var downArrowEncrypt: UIImageView!
    @IBOutlet var upArrowDecrypt: UIImageView!
    
    var chosenCipher: Int = 0
    var chosenCipherClass: Cipher.Type!
    
    
    @IBAction func btnEncrypt() {
        if !txtOpenText.text.isEmpty {
            txtOpenText.text = Utils.rewriteTextToASCIIChars(txtOpenText.text)
            if isKeyValid() {
                txtCodedText.text = chosenCipherClass.encrypt(txtOpenText.text, withKey: txtKey.text)
            }
            keyVisibilityUpdate()
        }
    }
    
    @IBAction func btnDecrypt() {
        if !txtCodedText.text.isEmpty {
            if isKeyValid() {
                txtOpenText.text = chosenCipherClass.decrypt(txtCodedText.text, withKey: txtKey.text)
            }
            keyVisibilityUpdate()
        }
    }
    
    @IBAction func btnRandomKey() {
        txtKey.text = chosenCipherClass.generateRandomKey()
        keyView.alpha = 0;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateChosenCipher()
        reloadChosenCipherClass()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        bgView.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        txtKey.delegate = self
        
        encryptButton.layer.borderColor = UIColor.grayColor().CGColor
        encryptButton.layer.borderWidth = 1
        encryptButton.layer.cornerRadius = 3
        decryptButton.layer.borderColor = UIColor.grayColor().CGColor
        decryptButton.layer.borderWidth = 1
        decryptButton.layer.cornerRadius = 3
        randomKeyButton.layer.borderColor = UIColor.grayColor().CGColor
        randomKeyButton.layer.borderWidth = 1
        randomKeyButton.layer.cornerRadius = 3
        randomKeyButton.alpha = 0
        downArrowEncrypt.alpha = 0.5
        upArrowDecrypt.alpha = 0.5
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        updateChosenCipher()
        reloadChosenCipherClass()
        
        // print("EncryptionController: \n  chosenCipher: \(chosenCipher) \n  chosenCipherClass: \(chosenCipherClass) ")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 26
        let currentString: NSString = textField.text!
        let newString: NSString = currentString.stringByReplacingCharactersInRange(range, withString: string)
                    
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    func isKeyValid() -> Bool {
        
        if isKeyEmptyAlert() {
            randomKeyButton.alpha = 1
            return false
        }
        
        keyFillIfNeeded()
        
        if !isKeyAllowedAlert() {
            randomKeyButton.alpha = 1
            return false
        }
        else {
            keyView.alpha = 0;
            randomKeyButton.alpha = 0
            txtKey.resignFirstResponder()
            return true
        }
    }
    
    func keyFillIfNeeded() {
        // if cipher is monoalphabetic, key must be long as the alphabet
        if chosenCipher == 2 {
            // short key will fill to alphabet count length (LETTER_COUNT = 26)
            let key = txtKey.text
            
            txtKey.text = Monoalphabetic.fillToAllowedKey(key)
        }
    }
    
    // zkontroluje, zda je klíč validní vzhledem k aktuální šifře
    func isKeyAllowedAlert() -> Bool {
        
        if chosenCipherClass.isAllowedKey(txtKey.text) {
            return true
        }
        else {
            let message = "Entered key is not valid with this type of cipher. Generate random key to see example or read the Explanation."
            let alert = UIAlertController(title: "Key error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    // zkontroluje, zda není textové pole pro klíč prázdné
    func isKeyEmptyAlert() -> Bool {
        
        if txtKey.text!.isEmpty {
            let message = "Key is empty. You can generate a random key by pressing \"Random key\" button."
            let alert = UIAlertController(title: "Key error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return true
        }
        else {
            return false
        }
    }

    
    func updateChosenCipher() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let cipher = userDefaults.objectForKey("cipher") {
            chosenCipher = cipher as! Int
        }
    }
    
    func reloadChosenCipherClass() {
        switch chosenCipher {
        case 0:
            chosenCipherClass = Caesar.self
        case 1:
            chosenCipherClass = Vigenere.self
        case 2:
            chosenCipherClass = Monoalphabetic.self
        case 3:
            chosenCipherClass = Transposition.self
        default:
            chosenCipherClass = Vigenere.self
        }
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func keyVisibilityUpdate() {
        if txtKey.text == "" {
            keyView.alpha = 0.6
        } else {
            keyView.alpha = 0
        }
    }
    
    @IBAction func keyTapIn() {
        keyView.alpha = 0;
        randomKeyButton.alpha = 1
    }
    
    @IBAction func keyTapOut() {
        if txtKey.text == "" {
            keyView.alpha = 0.6
        }
        randomKeyButton.alpha = 0
    }
    
}
