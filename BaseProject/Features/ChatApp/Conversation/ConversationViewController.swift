//
//  ConversationViewController.swift
//  BaseProject
//
//  Created by Nguyen Tran on 11/3/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        valideAuth()
       
    }
    
}

// MARK: - Event
extension ConversationViewController {
    private func valideAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false, completion: nil)
        }
    }
}
