//
//  MainController.swift
//  Glam Art Media
//
//  Created by Andrew on 11/19/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class RegisterView: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FBSDKLoginButtonDelegate {
    
    let userDefaults = UserDefaults()
    let defaults = UserDefaults(suiteName: "group.com.glamartmedia.extension")
    
    lazy var fbButton: FBSDKLoginButton = {
        var button = FBSDKLoginButton()
        button.readPermissions = ["public_profile, email"]
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    let leftLine: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let rightLine: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let signUpButton: UIButton = {
        let btt = UIButton(type: .system)
        btt.translatesAutoresizingMaskIntoConstraints = false
        btt.setTitle("Sign Up", for: .normal)
        btt.backgroundColor = .blue
        btt.setTitleColor(.white, for: .normal)
        btt.addTarget(self, action: #selector(signUpBtt), for: .touchUpInside)
        return btt
    }()
    
    let imagePickerButton: UIButton = {
        let btt = UIButton(type: .system)
        btt.translatesAutoresizingMaskIntoConstraints = false
        btt.setTitle("Choose Photo", for: .normal)
        btt.addTarget(self, action: #selector(profileImagePicker), for: .touchUpInside)
        return btt
    }()
    
    lazy var googleSignIn: GIDSignInButton = {
        let btt = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2 - 30, height: 30))
        btt.translatesAutoresizingMaskIntoConstraints = false
        return btt
    }()
    
    override func viewDidLoad(){
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().uiDelegate = self
        view.backgroundColor = .white

        
        
        view.addSubview(emailAdressTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(imagePickerButton)
        view.addSubview(leftLine)
        view.addSubview(orLabel)
        view.addSubview(rightLine)
        view.addSubview(googleSignIn)
//        view.addSubview(fbButton)
        addConstraints()
    }
    
    
    @objc func profileImagePicker(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var finPic: UIImage!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        var finalPicture: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage{
            finalPicture = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage{
            finalPicture = originalImage
        }
        
        if let selectedPicture = finalPicture{
            finPic = selectedPicture
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signUpBtt(){
        guard let emailStr = emailAdressTextField.text else { return }
        guard let passStr = passwordTextField.text else { return }
        
        FirebaseService.sharedInstance.createUser(emailStr: emailStr, password: passStr, userImage: finPic) { (uid, state) in
            if state{
                print("Data uploaded")
                self.userDefaults.set(true, forKey: "userLogged")
                self.defaults?.set(uid, forKey: "userId")
                self.defaults?.synchronize()
                let mainController = MainController()
                mainController.modalPresentationStyle = .fullScreen
                self.present(mainController, animated: true, completion: nil)
            }
        }
    }
    
    func addConstraints(){
        
        NSLayoutConstraint.activate([
            emailAdressTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            emailAdressTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailAdressTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.topAnchor.constraint(equalTo: emailAdressTextField.bottomAnchor, constant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            imagePickerButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
            imagePickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePickerButton.heightAnchor.constraint(equalToConstant: 100),
            imagePickerButton.widthAnchor.constraint(equalToConstant: 100),
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 100),
            signUpButton.widthAnchor.constraint(equalToConstant: 100),
            
            googleSignIn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            googleSignIn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60),
            
            leftLine.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            leftLine.bottomAnchor.constraint(equalTo: self.googleSignIn.topAnchor, constant: -20),
            leftLine.heightAnchor.constraint(equalToConstant: 1),
            leftLine.widthAnchor.constraint(equalToConstant: 30),
            
            orLabel.leftAnchor.constraint(equalTo: leftLine.rightAnchor, constant: 10),
            orLabel.centerXAnchor.constraint(equalTo: leftLine.centerXAnchor),
            orLabel.rightAnchor.constraint(equalTo: leftLine.leftAnchor, constant: -10),
            
            rightLine.leftAnchor.constraint(equalTo: self.orLabel.rightAnchor, constant: 25),
            rightLine.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25),
            rightLine.bottomAnchor.constraint(equalTo: self.googleSignIn.topAnchor, constant: -20),
            rightLine.heightAnchor.constraint(equalToConstant: 1),
            rightLine.widthAnchor.constraint(equalToConstant: 30)
            
//            fbButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            fbButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            fbButton.heightAnchor.constraint(equalToConstant: 30),
//            fbButton.widthAnchor.constraint(equalToConstant: 30)
        ])
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
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("disconnected!")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("Hellya I am loggin in!")
        if !result.isCancelled{
            print("Canceled!")
            return
        }else{
            getDataFromFacebook()
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.dismiss(animated: true, completion: nil)
    }

    func getDataFromFacebook(){
        guard let fbToken = FBSDKAccessToken.current()?.tokenString else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: fbToken)
        Auth.auth().signIn(with: credential) { (user, err) in
            if err != nil{
                print(err?.localizedDescription)
                return
            }
            if let uid = user?.user.uid as? String{
                self.sendDataToFirebase(uid: uid)
            }
        }
    }

    func sendDataToFirebase(uid: String){
        let param = ["fields":"email,name,picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: param).start { (conn, result, err) in
            if err != nil {
                print(err?.localizedDescription)
                return
            }

            guard let dataObj = result as? NSDictionary else { return }

            print(dataObj)
        }
    }
    
    
}

struct RegisterPreview: PreviewProvider{
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<RegisterPreview.ContainerView>) {
            
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<RegisterPreview.ContainerView>) -> UIViewController {
            return RegisterView()
        }
    }
    
}
