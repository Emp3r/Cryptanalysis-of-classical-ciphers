import Foundation
import UIKit

class ExplanationViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var explanationWebView: UIWebView!
    
    var chosenCipher: Int = 0
    var cipherData = []
    
    
    func fillExplanation() {
        let cipher = cipherData[chosenCipher] as! String
        let fileUrl = NSBundle.mainBundle().URLForResource(cipher, withExtension:"html")
        
        let urlRequest = NSURLRequest(URL: fileUrl!)
        
        explanationWebView.loadRequest(urlRequest)
        
    }
    
    func updateChosenCipher() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let cipher = userDefaults.objectForKey("cipher") {
            
            if chosenCipher == cipher as! Int {
                return false
            }
            else {
                chosenCipher = cipher as! Int
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        cipherData = Utils.availableCiphersNormalized()
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        updateChosenCipher()
        fillExplanation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if updateChosenCipher() {
            fillExplanation()
        }
        
        // print("ExplanationController: \n  chosenCipher: \(chosenCipher) \n  cipherData: \(cipherData) ")
        
    }
    
    
}
