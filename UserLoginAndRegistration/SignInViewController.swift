//
//  SignInViewController.swift
//  UserLoginAndRegistration
//
//  Created by Leo Li on 2019-02-08.
//  Copyright © 2019 Leo Li. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("sign in button tapped")
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        self.present(registerViewController, animated:true)
    }
    @IBAction func registerNewButtonTapped(_ sender: Any) {
        print("register account button tapped")
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        self.present(registerViewController, animated:true)
        //created a new constant, which is presented to the user as registerViewController
    }

}
