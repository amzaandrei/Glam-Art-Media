//
//  LogInView.swift
//  Glam Art Media
//
//  Created by Andrew on 12/11/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class LogInViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    let userDefaults = UserDefaults()
    let defaults = UserDefaults(suiteName: "group.com.glamartmedia.extension")
    
    var logInLabelBl: Bool! {
        didSet{
            
        }
    }
    
    
    let logInLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let pleaseLogInLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let logInInstLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var googleSignIn: GIDSignInButton = {
        let btt = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2 - 30, height: 30))
        btt.translatesAutoresizingMaskIntoConstraints = false
        return btt
    }()
    
    let orLogInInstLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    @objc let emailAdressTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Set your email adress..."
        textField.backgroundColor = UIColor.clear
        return textField
    }()
    
    @objc let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Set your password.."
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        return textField
    }()
    
    let forgotButton: UIButton = {
        let btt = UIButton(type: .system)
        btt.translatesAutoresizingMaskIntoConstraints = false
        btt.setTitle("Forgot your password", for: .normal)
//        btt.addTarget(self, action: #selector(signUpBtt), for: .touchUpInside)
        return btt
    }()
    
    let logInButton: UIButton = {
        let btt = UIButton(type: .system)
        btt.translatesAutoresizingMaskIntoConstraints = false
        btt.setTitle("Log in", for: .normal)
        btt.backgroundColor = .blue
        btt.setTitleColor(.white, for: .normal)
//        btt.addTarget(self, action: #selector(signUpBtt), for: .touchUpInside)
        return btt
    }()
    
    let dontYouLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let registerButton: UIButton = {
            let btt = UIButton(type: .system)
            btt.translatesAutoresizingMaskIntoConstraints = false
            btt.setTitle("Log in", for: .normal)
            btt.backgroundColor = .blue
            btt.setTitleColor(.white, for: .normal)
    //        btt.addTarget(self, action: #selector(signUpBtt), for: .touchUpInside)
            return btt
    }()
    
    let rememberMeCheck: BEMCheckBox = {
        let circle = BEMCheckBox()
        circle.translatesAutoresizingMaskIntoConstraints = true
        return circle
    }()
    
    let rememberMeCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().uiDelegate = self
        
        view.addSubview(logInLabel)
        view.addSubview(pleaseLogInLabel)
        view.addSubview(logInInstLabel)
        view.addSubview(googleSignIn)
        view.addSubview(orLogInInstLabel)
        view.addSubview(emailAdressTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotButton)
        view.addSubview(logInButton)
        view.addSubview(dontYouLabel)
        view.addSubview(registerButton)
        view.addSubview(rememberMeCheck)
        view.addSubview(rememberMeCheckLabel)
        
        
        addConstraints()
    }
    
    
    func addConstraints(){
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      
        if let error = error {
            print(error.localizedDescription)
            return
        }
        GoogleService.sharedInstance.getDataFromGoogle(userGg: user) { (uid, state) in
            if state{
                print("your logged")
                self.userDefaults.set(true, forKey: "userLogged")
                self.defaults?.set(uid, forKey: "userId")
                self.defaults?.synchronize()
                let mainController = MainController()
                mainController.modalPresentationStyle = .fullScreen
                self.present(mainController, animated: true, completion: nil)
            }
        }
    }
    
}
