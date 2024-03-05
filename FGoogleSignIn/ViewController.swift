//
//  ViewController.swift
//  FGoogleSignIn
//
//  Created by Rambali Kumar on 03/03/24.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth
import iZootoiOSSDK

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        googleSignIn()
        
    }
   
    func googleSignIn(){
        DispatchQueue.main.async {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if error != nil || user == nil {
                    // Show the app's signed-out state.
                    GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                        guard error == nil else {
                                // Handle the error, e.g., user canceled sign-in
                                return
                            }
                        let userName = signInResult?.user.profile?.name
                        let email = signInResult?.user.profile?.email
                        iZooto.syncUserDetailsEmail(email: email!, fName: userName!, lName: "")
                        // If sign in succeeded, display the app's main content View.
                    }
                } else {
                    // Show the app's signed-in state.
                    UserDefaults.standard.set("true", forKey: "isLogedIn")
                    print("Signed In")
                    
                }
            }
        }
    }
    
    @IBAction func signInBtnClicked(_ sender: UIButton) {
        
        
    }
}

