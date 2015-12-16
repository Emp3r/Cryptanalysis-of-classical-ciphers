import Foundation
import UIKit

class CryptanalysisViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var txtToCrack: UITextView!
    @IBOutlet var txtGuessed: UITextView!
    @IBOutlet var txtKeyGuess: UITextField!
    @IBOutlet var keyView: UIImageView!
    @IBOutlet var crackButton: UIButton!
    
    var chosenCipher: Int = 0
    var chosenAttack: Int = 0
    var chosenCipherClass: Cipher.Type!
    var chosenAttackFunction: (String! -> String!)!
    
    
    // button actions
    @IBAction func btnCrack() {
        let text = txtToCrack.text
        
        if !text.isEmpty {
            // start loader animation?
            let keyGuess = chosenAttackFunction(text)
            
            keyView.alpha = 0
            txtKeyGuess.text = keyGuess
            txtGuessed.text = chosenCipherClass.decrypt(text, withKey: keyGuess)
        
            txtKeyGuess.userInteractionEnabled = true
            txtGuessed.userInteractionEnabled = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateChosenCipherAndAttack()
        reloadChosenCipherClass()
        reloadChosenAttackFunction()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        bgView.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        txtKeyGuess.delegate = self
        txtKeyGuess.userInteractionEnabled = false
        txtGuessed.userInteractionEnabled = false
        
        crackButton.layer.borderColor = UIColor.grayColor().CGColor
        crackButton.layer.borderWidth = 1
        crackButton.layer.cornerRadius = 3
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        updateChosenCipherAndAttack()
        reloadChosenCipherClass()
        reloadChosenAttackFunction()
        
        // print("CryptanalysisController: \n  chosenCipher: \(chosenCipher) \n  chosenAttack: \(chosenAttack) \n  function: \(chosenAttackFunction) ")
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
    
    
    func updateChosenCipherAndAttack() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let cipher = userDefaults.objectForKey("cipher") {
            chosenCipher = cipher as! Int
        }
        if let attack = userDefaults.objectForKey("attack") {
            chosenAttack = attack as! Int
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
    
    func reloadChosenAttackFunction() {
        switch chosenCipher {
        case 0:
            switch chosenAttack {
            case 0: chosenAttackFunction = CaesarCrack.frequencyAnalysisKeyGuess
            case 1: chosenAttackFunction = CaesarCrack.realWordsAnalysisKeyGuess
            case 2: chosenAttackFunction = CaesarCrack.lettersDistanceKeyGuess
            default: chosenAttackFunction = CaesarCrack.frequencyAnalysisKeyGuess
            }
        case 1:
            switch chosenAttack {
            case 0: chosenAttackFunction = VigenereCrack.frequencyAnalysisKeyGuess
            case 1: chosenAttackFunction = VigenereCrack.lettersDistanceKeyGuess
            default: chosenAttackFunction = VigenereCrack.frequencyAnalysisKeyGuess
            }
        case 2:
            chosenAttackFunction = MonoalphabeticCrack.uniqueWordsKeyGuess
        case 3:
            switch chosenAttack {
            case 0: chosenAttackFunction = TranspositionCrack.findingWordKeyGuess
            case 1: chosenAttackFunction = TranspositionCrack.realWordsAnalysisKeyGuess
            default: chosenAttackFunction = TranspositionCrack.realWordsAnalysisKeyGuess
            }
        default:
            chosenAttackFunction = CaesarCrack.frequencyAnalysisKeyGuess
        }
    }
    
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func keyTapIn() {
        keyView.alpha = 0
    }
    
    @IBAction func keyTapOut() {
        if txtKeyGuess.text == "" {
            keyView.alpha = 0.6
        }
    }
    
    
}
