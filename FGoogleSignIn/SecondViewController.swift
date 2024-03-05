//
//  SecondViewController.swift
//  FGoogleSignIn
//
//  Created by Rambali Kumar on 04/03/24.
//

import UIKit
import GoogleSignIn

class SecondViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutBtnClicked(_ sender: Any) {
        GIDSignIn.sharedInstance.signOut()
//        print("Sign Out: \(GIDSignIn.sharedInstance.signOut())")

    }
    
    

}
