//
//  HomePageViewController.swift
//  UserLoginAndRegistration
//
//  Created by home on 2/27/19.
//  Copyright © 2019 Leo Li. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signoutButtonTapped(_ sender: Any) {
        print("Sign out button tapped")
    }
    @IBAction func loadMemberButtonTapped(_ sender: Any) {
        print("load member profile button tapped")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
