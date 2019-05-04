//
//  LoginView.swift
//  WePool
//
//  Created by Raj Kadiyala on 5/2/19.
//  Copyright © 2019 WePool. All rights reserved.
//

import UIKit

class LoginView : UIView{
    
    var bottomStackView : UIStackView!
    
    let upoolImageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "UPoolLogo"))
        view.contentMode = .scaleAspectFit
        view.tintColor = Colors.maroon
        return view
    }()
    
    let bottomContainer : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.alpha = 0.9
        return view
    }()
    
    let emailTextField : UITextField = {
        let txtField = UITextField.getTextField(Strings.emailPlaceholder)
        return txtField
    }()
    
    let passwordTextField : UITextField = {
        let txtField = UITextField.getTextField(Strings.passwordPlaceholder)
        txtField.isSecureTextEntry = true
        return txtField
    }()
    
    let facebookButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Facebook", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.helvetica, size: 24)
        button.backgroundColor = UIColor.blue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    let googleButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Google", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.helvetica, size: 24)
        button.backgroundColor = UIColor.red
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.login, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.helvetica, size: 24)
        button.backgroundColor = Colors.maroon
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    let forgotPwdButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.forgotPwd, for: .normal)
        button.setTitleColor(Colors.maroon, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.helvetica, size: 14)
        button.backgroundColor = UIColor.clear
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    let dontHaveAccLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.helvetica, size: 14)
        label.text = Strings.noAccount
        return label
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.signUp, for: .normal)
        button.setTitleColor(Colors.maroon, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.helvetica, size: 14)
        button.backgroundColor = UIColor.clear
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    let umassBackgroundImageView : UIImageView = {
        let image = UIImage(named: Images.umassBackgroundImage)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.alpha = 0.5
        return imageView
    }()
    
    let errorLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackViews()
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackViews(){
        //Empty UIVIew
        let emptyUIView = UIView()
        
        //Label + Signup button
        let labelAndSignUpStackView = UIStackView(arrangedSubviews: [dontHaveAccLabel, signUpButton])
        labelAndSignUpStackView.axis = .horizontal
        labelAndSignUpStackView.spacing = 5
        labelAndSignUpStackView.alignment = .center
        
        // bottom Label StackView
        let bottomlabelStackView = UIStackView(arrangedSubviews: [forgotPwdButton,labelAndSignUpStackView])
        bottomlabelStackView.axis = .vertical
        bottomlabelStackView.alignment = .center
        
        //Bottom stack view
        bottomStackView = UIStackView(arrangedSubviews: [ emptyUIView, emailTextField, passwordTextField, errorLabel, facebookButton, googleButton, loginButton,bottomlabelStackView])
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 25
        bottomStackView.alignment = .center
        bottomStackView.backgroundColor = UIColor.white
        
    }
    
    func setupUI(){
        backgroundColor = UIColor.white
        
        bottomContainer.addSubview(bottomStackView)
        addSubview(bottomContainer)
        addSubview(umassBackgroundImageView)
        
        //Blur Effect
    
        /*let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)*/
        
        addSubview(upoolImageView)
        bringSubviewToFront(bottomContainer)
    }
    
    func setupConstraints(){
        
        //UPoolLabel
        upoolImageView.translatesAutoresizingMaskIntoConstraints = false
        upoolImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        upoolImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant :150).isActive = true
        upoolImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        upoolImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        
        //BottomContainer View Constraints
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        bottomContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomContainer.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.58).isActive = true
        
        //Bottom Stack View Constraints
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.bottomAnchor.constraint(equalTo: bottomContainer.safeAreaLayoutGuide.bottomAnchor, constant:-15).isActive = true
        bottomStackView.leadingAnchor.constraint(equalTo: bottomContainer.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: bottomContainer.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomStackView.topAnchor.constraint(equalTo: bottomContainer.topAnchor).isActive = true
        
        //Email and password field constraints
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor, multiplier: 0.8).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor, multiplier: 0.8).isActive = true
        
        //Facebook Button Constraints
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor, multiplier: 0.8).isActive = true
        
        //Google Button Constraints
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor, multiplier: 0.8).isActive = true
        
        //Login Button Constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor, multiplier: 0.8).isActive = true
        
        //Umass Image constraints
        umassBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        umassBackgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        umassBackgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        umassBackgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        umassBackgroundImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, constant: 15).isActive = true
        
    }
}
