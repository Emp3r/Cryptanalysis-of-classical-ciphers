import UIKit

class AboutAppViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func visitWebsitePressed(sender: AnyObject) {
        let website = "https://github.com/Emp3r/Cryptanalysis-of-classical-ciphers"
        UIApplication.sharedApplication().openURL(NSURL(string: website)!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.navigationController!.navigationBar.barTintColor = UIColor(white: 0.88, alpha: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
