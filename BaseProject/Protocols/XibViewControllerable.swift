//
//  XibViewControllerable.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/21/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

protocol XibViewControllerable {
    static var name: String { get }
    static func create() -> Self
}

extension XibViewControllerable where Self: UIViewController {
    static var name: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    static func create() -> Self {
        return self.init(nibName: Self.name, bundle: nil)
    }
}
