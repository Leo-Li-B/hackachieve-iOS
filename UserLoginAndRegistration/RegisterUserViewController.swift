//
//  RegisterUserViewController.swift
//  UserLoginAndRegistration
//
//  Created by Leo Li on 2019-02-08.
//  Copyright © 2019 Leo Li. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        print("cancel button tapped")
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("sign up button tapped")
        
        //validate the fields are not empty
        if  (firstNameTextField.text?.isEmpty)! ||
            (lastNameTextField.text?.isEmpty)! ||
            (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)!
        {
            //Display alert Message and return
            displayMessage(userMessage: "All fields are required")
            return
        }
        //validate password
        if
            ((passwordTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true)
        {
            displayMessage(userMessage: "Please make sure that the passwords match")
            return
            
        }
        //create an activity indicator showing how long it takes to load the request
        //create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        //position activity indicator in the center
        myActivityIndicator.center = view.center
        
        //If needed, you can prevent activity indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        //start activity indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        //Send HTTP request to server!!
        //Placeholder text
        let myUrl = URL(string: "https://hackachieve.com:8000/user/register")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"//Compose a query string
        request.addValue("Basic Og==", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let postString = ["firstName": firstNameTextField.text!,
                          "lastName": lastNameTextField.text!,
                          "userName": emailTextField.text!,
                          "userPassword": passwordTextField.text!,
        ] as [String: String]
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong, Try again")
            return
        }
        //sending the HTTP request
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error: Error?) in
            
           //extra function to remove activity indicator
            self.removeActivityIndicator(activityIndicator:myActivityIndicator)
            if error != nil
            {
                self.displayMessage(userMessage: "could not successfully perform this request. Please try again later")
                print("error =\(String(describing:error))")
                return
            }
            //convert response sent from a server side code to a NSdictionary object
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json{
                    let userId = parseJSON["userId"] as? String
                    print("User id: \(String(describing:userId!))")
                    if (userId?.isEmpty)!
                    {
                        //display alert with error msg
                    self.displayMessage(userMessage: "could not successfully perform this request. Please try again later")
                        return
                    } else {
                    self.displayMessage(userMessage: "Successfully registered a new account. please proceed to sign in")
                    }
                } else {
                    self.displayMessage(userMessage: "could not successfully perform this request. Please try again later")
                }
                
            }  catch {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                self.displayMessage(userMessage: "could not successfully perform this request. Please try again later")
                print(error)
            }
            
        }
            
            
            
            task.resume()
            
        }
        func removeActivityIndicator(activityIndicator: UIActivityIndicatorView){
            DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
        
    
    
    //function to create a user alert message
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
            //creating an alertController
            let alertController = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert)
            
            let OKaction = UIAlertAction(title: "OK", style: .default)
            { (action:UIAlertAction!)in
            //Code in this block will trigger when OK button tapped.
            print("OK button tapped")
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
            //presenting the alertController
        alertController.addAction(OKaction)
        self.present(alertController, animated: true, completion: nil)
    }
}
}
