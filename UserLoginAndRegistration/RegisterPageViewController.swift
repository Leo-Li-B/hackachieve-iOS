//
//  RegisterPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by Leo Li on 2019-02-08.
//  Copyright © 2019 Leo Li. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func registerButtonTapped(_ sender: Any) {
//        let userEmail = userEmailTextField.text;
//        let userPassword = userPasswordTextField.text;
//        let userRepeatPassword = repeatPasswordTextField.text;
//        
        //check for empty fields
//        if(userEmail.isEmpty || userPassword.isEmpty || userRepeatPassword)
//        {
//            //display alert msg
//            displayMyAlertMessage("All fields are required")
//            return;
//        }
//        // check if passwords match
//        if(userPassword != userRepeatPassword)
//        {
//            displayMyAlertMessage("Passwords do not match")
//            return;
//        }
//    }
//
//    func dispayMyAlertMessage(userMessage:String)
//    {
//        var myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
//    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
