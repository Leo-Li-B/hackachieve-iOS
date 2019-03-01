//
//  SignInViewController.swift
//  UserLoginAndRegistration
//
//  Created by Leo Li on 2019-02-08.
//  Copyright © 2019 Leo Li. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SignInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("sign in button tapped")
        
        // read value from text fields
        let userName = userNameTextField.text
        let userPassword = userPasswordTextField.text
        if (userName? .isEmpty)! || (userPassword?.isEmpty)!
        {
            print("User name \(String(describing: userName)) or password \(String(describing: userPassword)) is empty")
            displayMessage(userMessage:"one of the required fields is missing")
            return
        }
        
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
        let myUrl = URL(string: "http://localhost:8080/api/authentication")
        //convert to url request
        var request = URLRequest(url:myUrl!)
        //configure http method with headers and parameters
        request.httpMethod = "POST"//Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //convert keypairs to json payload
        let postString = ["userName": userName!, "userPassword": userPassword!] as [String:String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong, Try again")
            return
        }
        //when task executes, the data from json will be stored in the data
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
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
                    //json named payload, will contain user id and token
                    let accessToken = parseJSON["token"] as? String
                    let userId = parseJSON["id"] as? String
                    //print("Access token: \(String(describing: accessToken!))")
                    let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                    let saveUserId: Bool = KeychainWrapper.standard.set(userId!, forKey: "userId")
                    
                    print("The access token save result: \(saveAccessToken)")
                    print("The userId save result \(saveUserId)")
                    
                    if (accessToken?.isEmpty)!
                    {
                        //display alert with error msg
                        self.displayMessage(userMessage: "could not successfully perform this request. Please try again later")
                        return
                    }
                    
                    DispatchQueue.main.async
                    {
                        let homePage = self.storyboard?.instantiateViewController(withIdentifier:
                            "HomePageViewController") as! HomePageViewController
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = homePage
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
    
    
        @IBAction func registerNewButtonTapped(_ sender: Any) {
            print("register account button tapped")
        
            let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
            self.present(registerViewController, animated:true)
            //created a new constant, which is presented to the user as registerViewController
    }
    @IBAction func adminLogin(_ sender: Any) {
        //go to homepage
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        self.present(registerViewController, animated:true)
    }
    
    
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
    
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView){
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    
}
