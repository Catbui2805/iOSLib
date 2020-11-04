//
//  LoginViewController.swift
//  BaseProject
//
//  Created by Nguyen Tran on 11/3/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    lazy var sv: UIScrollView = {
        let sv = UIScrollView()
        sv.clipsToBounds = true
        return sv
    }()
    
    lazy var iv: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_messenger")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var tfEmail: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.returnKeyType = .continue
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.placeholder = "Email Address..."
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftViewMode = .always
        tf.backgroundColor = .white
        tf.delegate = self
        return tf
    }()
    
    lazy var tfPassword: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.returnKeyType = .done
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.placeholder = "Password..."
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftViewMode = .always
        tf.backgroundColor = .white
        tf.isSecureTextEntry = true
        tf.delegate = self
        return tf
    }()
    
    lazy var btLogin: UIButton = {
       let bt = UIButton()
        bt.setTitle("Log In", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        if #available(iOS 13.0, *) {
            bt.backgroundColor = .link
        } else {
            // Fallback on earlier versions
            bt.backgroundColor = .blue
        }
        bt.layer.masksToBounds = true
        bt.layer.cornerRadius = 12
        bt.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        bt.addTarget(self, action: #selector(btLoginTapped), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sv.frame = view.bounds
        
        let size = sv.width / 3
        iv.frame = CGRect(x: (sv.width - size) / 2, y: 20,
                          width: size, height: size)
        tfEmail.frame = CGRect(x: 30, y: iv.bottom + 10,
                               width: sv.width - 60 , height: 52)
        tfPassword.frame = CGRect(x: 30, y: tfEmail.bottom + 10,
                                  width: sv.width - 60, height: 52)
        btLogin.frame = CGRect(x: 30, y: tfPassword.bottom + 20,
                                  width: sv.width - 60, height: 52)
    }
}

// MARK: - Event
extension LoginViewController {
    @objc func didTapRegister() {
        
        tfEmail.resignFirstResponder()
        tfPassword.resignFirstResponder()
        
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btLoginTapped() {
        
        tfEmail.resignFirstResponder()
        tfPassword.resignFirstResponder()
        
        guard let email = tfEmail.text, let password = tfPassword.text,
              !email.isEmpty, !password.isEmpty, password.count > 6 else {
            alertUserLoginError()
            return
        }
        
        // - Firebase login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else { return }
            guard let result = result, error == nil else {
                print("==>> Failed to log in user with email: \(email)")
                return
            }
            
            let user = result.user
            print("==>> Logged in user: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to log in.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Setup views
extension LoginViewController {
    func setupViews() {
        view.backgroundColor = .white
        title = "Log in"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        view.addSubview(sv)
        sv.addSubview(iv)
        sv.addSubview(tfEmail)
        sv.addSubview(tfPassword)
        sv.addSubview(btLogin)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfEmail {
            tfPassword.becomeFirstResponder()
        } else if textField == tfPassword {
            btLoginTapped()
        }
        
        return true
    }
    
}
