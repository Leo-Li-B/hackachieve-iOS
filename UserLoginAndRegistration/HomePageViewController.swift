//
//  HomePageViewController.swift
//  UserLoginAndRegistration
//
//  Created by home on 2/27/19.
//  Copyright © 2019 Leo Li. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class HomePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var fullNameLabel: UILabel!
    
    let mainCategories = ["Health", "Career", "Finances", "Personal Development", "Spiritural", "Fun and Recreation"]
    
    let mainImages = [UIImage(named:"health"),
                      UIImage(named:"career"),
                      UIImage(named:"finances"),
                      UIImage(named:"personalDevelopment"),
                      UIImage(named:"spiritural"),
                      UIImage(named:"funAndRecreation"), ]
    
    let mainDescriptions = ["Goals to get in shape", "Achievements in my career", "Buying what I want", "Improve myself", "Become a meditation master", "Learn a new hobby"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!
        HomePageCollectionViewCell
        
        cell.mainCategory.text = mainCategories[indexPath.row]
        cell.mainImage.image = mainImages[indexPath.row]
        cell.mainDescription.text = mainDescriptions[indexPath.row]
        
        
        //This creates a drop shadow on the cell item
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

        
        return cell
    }
    //does not work for some reason, want to change each cell color
    private  func collectionView(_ collectionView: UICollectionView, cellforItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = indexPath.row == 0 ? .cyan: .orange;
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailCollectionViewController") as! DetailCollectionViewController
        self.present(detailViewController, animated:true)

    }

    @IBAction func signoutButtonTapped(_ sender: Any) {
        print("Sign out button tapped")
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        KeychainWrapper.standard.removeObject(forKey: "userId")
        
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier:
            "SignInViewController") as! SignInViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = signInPage
        
    }
    @IBAction func loadMemberButtonTapped(_ sender: Any) {
        print("load member profile button tapped")
        loadMemberProfile()
    }
    func loadMemberProfile()
    {
        let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        let userId: String? = KeychainWrapper.standard.string(forKey: "userId")
        
        //send HTTP request to get user ID - Placeholder
        let myUrl = URL(string: "http://localhost:8080/api/users/\(userId!)")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET" //compose query string
        request.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data:Data?, response: URLResponse?, error:Error?) in
            
            if error != nil
            {
                self.displayMessage(userMessage: "could not successfully perform this request. Please try again later")
                print("error =\(String(describing:error))")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    DispatchQueue.main.async
                        {
                        let firstName: String? = parseJSON["firstName"] as? String
                        let lastName: String? = parseJSON["lastName"] as? String
                        
                        if firstName?.isEmpty != true && lastName?.isEmpty != true {
                            self.fullNameLabel.text = firstName! + " " + lastName!
                        }
                    }
                } else {
                   self.displayMessage(userMessage: "could not successfully perform this request. Please try again later")
                }
            }  catch {
                self.displayMessage(userMessage: "could not successfully perform this request. Please try again later")
                print(error)
            }
        }
        task.resume()
    }
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                //creating an alertController
                let alertController = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert)
                
                let OKaction = UIAlertAction(title: "OK", style: .default)
                { (action:UIAlertAction!)in
                    //Code in this block will trigger when OK button tapped.
                    print("load profile button tapped")
                }
                   alertController.addAction(OKaction)
                    self.present(alertController, animated: true, completion: nil)
            }
    }
}
