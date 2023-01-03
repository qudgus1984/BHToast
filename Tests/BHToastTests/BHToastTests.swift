import XCTest
@testable import BHToast

import UIKit
import BHToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionAlert(_ sender: Any) {
        if #available(iOS 13.0, *) { 
        } else {
            // Fallback on earlier versions
        }
    }
}
