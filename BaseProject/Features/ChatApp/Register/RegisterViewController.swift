//
//  RegisterViewController.swift
//  BaseProject
//
//  Created by Nguyen Tran on 11/3/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    lazy var sv: UIScrollView = {
        let sv = UIScrollView()
        sv.clipsToBounds = true
        return sv
    }()
    
    lazy var iv: UIImageView = {
        let iv = UIImageView()
        if #available(iOS 13.0, *) {
            iv.image = UIImage(systemName: "person")
        } else {
            // Fallback on earlier versions
            iv.image = UIImage(named: "person")
        }
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var tfFirstName: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.returnKeyType = .continue
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.placeholder = "First name..."
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftViewMode = .always
        tf.backgroundColor = .white
        tf.delegate = self
        return tf
    }()
    
    lazy var tfLastName: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.returnKeyType = .continue
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.placeholder = "Last name..."
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftViewMode = .always
        tf.backgroundColor = .white
        tf.delegate = self
        return tf
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
    
    lazy var btRegister: UIButton = {
       let bt = UIButton()
        bt.setTitle("Register", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        if #available(iOS 13.0, *) {
            bt.backgroundColor = .green
        } else {
            // Fallback on earlier versions
            bt.backgroundColor = .green
        }
        bt.layer.masksToBounds = true
        bt.layer.cornerRadius = 12
        bt.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        bt.addTarget(self, action: #selector(btRegisterTapped), for: .touchUpInside)
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
        tfFirstName.frame = CGRect(x: 30, y: iv.bottom + 10,
                               width: sv.width - 60 , height: 52)
        tfLastName.frame = CGRect(x: 30, y: tfFirstName.bottom + 10,
                                  width: sv.width - 60, height: 52)
        tfEmail.frame = CGRect(x: 30, y: tfLastName.bottom + 10,
                               width: sv.width - 60 , height: 52)
        tfPassword.frame = CGRect(x: 30, y: tfEmail.bottom + 10,
                                  width: sv.width - 60, height: 52)
        btRegister.frame = CGRect(x: 30, y: tfPassword.bottom + 10,
                                  width: sv.width - 60, height: 52)
    }
}

// MARK: - Event
extension RegisterViewController {
   
    @objc func btRegisterTapped() {
        
        tfEmail.resignFirstResponder()
        tfPassword.resignFirstResponder()
        
        guard let email = tfEmail.text, let password = tfPassword.text,
              let firstName = tfFirstName.text, let lastName = tfLastName.text,
              !firstName.isEmpty, !lastName.isEmpty,
              !email.isEmpty, !password.isEmpty, password.count > 6 else {
            alertUserRegisterError()
            return
        }
        
        // TODO: - Firebase login
    }
    
    func alertUserRegisterError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to create a new account.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapChangeProfile() {
        print("change pic called")
    }
}

// MARK: - Setup views
extension RegisterViewController {
    func setupViews() {
        view.backgroundColor = .white
        title = "Create Account"
        
        view.addSubview(sv)
        sv.addSubview(iv)
        sv.addSubview(tfFirstName)
        sv.addSubview(tfLastName)
        sv.addSubview(tfEmail)
        sv.addSubview(tfPassword)
        sv.addSubview(btRegister)
        
        
        iv.isUserInteractionEnabled = true
        sv.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfile))
        iv.addGestureRecognizer(gesture)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfEmail {
            tfPassword.becomeFirstResponder()
        } else if textField == tfPassword {
            btRegisterTapped()
        }
        
        return true
    }
    
}
