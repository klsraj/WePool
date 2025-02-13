//
//  ProfileViewController.swift
//  WePool
//
//  Created by Raj Kadiyala on 5/2/19.
//  Copyright © 2019 WePool. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class ProfileViewController: UIViewController, NVActivityIndicatorViewable {
    
    let db = Firestore.firestore()
    var authUser : User?{
        return Auth.auth().currentUser
    }
    
    //ProfileView
    var profileView : ProfileView!
    
    var isEditingInfo : Bool = false {
        didSet{
            if isEditingInfo{
                profileView.pencilEditButton.setTitle("Save", for: .normal)
                profileView.pencilEditButton.setImage(nil, for: .normal)
                let userInfoFields = profileView.userInfoStackView.subviews as! [UserInfoField]
                for userInfoField in userInfoFields{
                    userInfoField.isUserInteractionEnabled = true
                }
            } else {
                let alert = UIAlertController(title: "Save", message: "Are you sure you want to save these changes?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
                    //Set alert view to make sure to save user info
                    self.view.endEditing(true)
                    self.profileView.pencilEditButton.setImage(UIImage(named: "PencilEdit"), for: .normal)
                    self.profileView.pencilEditButton.setTitle("", for: .normal)
                    let userInfoFields = self.profileView.userInfoStackView.subviews as! [UserInfoField]
                    for userInfoField in userInfoFields{
                        userInfoField.isUserInteractionEnabled = false
                    }
                    self.profileView.nameLabel.text = "\(self.profileView.userFirstName.subjectTextField.text ?? "") \(self.profileView.userLastName.subjectTextField.text ?? "" )"
                    self.saveUserInfoToDatabase()
                }))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        setupProfileView()
        retrieveUserData()
    }
    
    fileprivate func setupNavBar() {
        let image: UIImage = UIImage(named: "UPoolLogo")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        
        navigationItem.titleView = imageView
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(handleLogout))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapped))
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func setupProfileView() {
        profileView = ProfileView()
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        profileView.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageSelection)))
        profileView.pencilEditButton.addTarget(self, action: #selector(handlePencilEdit), for: .touchUpInside)
        profileView.myCarButton.addTarget(self, action: #selector(handleMyCar), for: .touchUpInside)
        profileView.settingsButton.addTarget(self, action: #selector(handleSettingsButton), for: .touchUpInside)
        
    }
    
    func retrieveUserData(){
        if let user = authUser{
            db.collection(FirebaseDatabaseKeys.usersKey).document(user.uid).getDocument { (snapshot, error) in
                guard let snapshot = snapshot, let dict = snapshot.data() else {return}
                if let user = WePoolUser(dictionary: dict){
                    self.profileView.thisUser = user
                }
            }
        }
    }
    
    //Save user information to database
    func saveUserInfoToDatabase(){
        guard let userId = profileView.thisUser?.uid else {return}
        var userInfo = [String : Any]()
        userInfo[FirebaseDatabaseKeys.UserFieldKeys.firstName] = profileView.userFirstName.subjectTextField.text
        userInfo[FirebaseDatabaseKeys.UserFieldKeys.lastName] = profileView.userLastName.subjectTextField.text
        userInfo[FirebaseDatabaseKeys.UserFieldKeys.gradYear] = profileView.userGradYear.subjectTextField.text
        userInfo[FirebaseDatabaseKeys.UserFieldKeys.major] = profileView.userMajor.subjectTextField.text
        userInfo["age"] = profileView.userAge.subjectTextField.text
        db.collection(FirebaseDatabaseKeys.usersKey).document(userId).setData(userInfo, merge: true) { (err) in
            
        }
    }
    
    func startActivity(){
        startAnimating(type: NVActivityIndicatorType.ballTrianglePath, color: Colors.maroon, displayTimeThreshold:2, minimumDisplayTime: 1)
    }
    
    @objc func handlePencilEdit(){
        if isEditingInfo{
            isEditingInfo = false
        } else {
            isEditingInfo = true
        }
    }
    
    @objc func handleTapped(){
        view.endEditing(true)
    }
    
    @objc func handleMyCar(){
        let myCarVC = MyCarViewController()
        myCarVC.thisUser = self.profileView.thisUser
        self.navigationController?.pushViewController(myCarVC, animated: true)
    }
    
    @objc func handleSettingsButton(){
        let profileSettingsVC = ProfileSettingsViewController()
        self.navigationController?.pushViewController(profileSettingsVC, animated: true)
    }
    
    @objc func handleLogout(){
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signOutAction = UIAlertAction(title: "Log Out", style: .default) { (_) in
            let currentUserId = self.authUser?.uid
            do {
                try Auth.auth().signOut()
            } catch {
            }
            if let currentUserId = currentUserId{
                let noFcmToken = [FirebaseDatabaseKeys.UserFieldKeys.fcmToken: ""]
                self.db.collection(FirebaseDatabaseKeys.usersKey).document(currentUserId).updateData(noFcmToken)
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(signOutAction)
        present(alert, animated: true, completion: nil)
    }
}
