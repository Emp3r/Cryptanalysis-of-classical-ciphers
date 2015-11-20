import Foundation
import UIKit

class ExplanationViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var explanationWebView: UIWebView!
    @IBOutlet var loader: UIActivityIndicatorView!
    
    var chosenCipher: Int = 0
    var cipherData = []
    
    
    func fillExplanation() {
        let cipher = cipherData[chosenCipher] as! String
        let fileUrl = NSBundle.mainBundle().URLForResource(cipher, withExtension:"html", subdirectory:"Explanations")
        
        let urlRequest = NSURLRequest(URL: fileUrl!)
        
        explanationWebView.loadRequest(urlRequest)
    }
    
    func updateChosenCipher() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let cipher = userDefaults.objectForKey("cipher") {
            
            if chosenCipher == cipher as! Int {
                return false
            } else {
                chosenCipher = cipher as! Int
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        cipherData = Utils.availableCiphersNormalized()
        super.viewDidLoad()
        
        explanationWebView.delegate = self
        explanationWebView.hidden = true
        
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
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        webView.hidden = true
        loader.hidden = false
        loader.startAnimating()
        return true;
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.hidden = false
        loader.hidden = true
        loader.stopAnimating()
    }
    
}
