import UIKit

class AboutAppViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func visitWebsitePressed(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://cryptanalysis.emper.cz")!)
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
