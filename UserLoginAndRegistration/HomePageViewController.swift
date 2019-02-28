//
//  HomePageViewController.swift
//  UserLoginAndRegistration
//
//  Created by home on 2/27/19.
//  Copyright © 2019 Leo Li. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
