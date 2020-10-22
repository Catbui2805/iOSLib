//
//  InterfaceInitable.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/21/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case none
}

protocol InterfaceInitable: InterfaceRepresentable {
    static func initFromNib() -> Self
    static func initFromStoryboard(id: Storyboard) -> Self
    var classId: String { get }
}

extension InterfaceInitable where Self: UIViewController {
    static func initFromNib() -> Self {
        return Self(nibName: classId, bundle: nil)
    }
    
    static func initFromStoryboard(id: Storyboard = .none) -> Self {
        let storyboardId = id == .none ? classId : id.rawValue
        let storyboard = UIStoryboard.init(name: storyboardId, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: classId) as? Self else {
            fatalError("==>> classId không khớp với storyboard identifier.")
        }
        return vc
    }
    
    var classId: String {
        return String(describing: type(of: self))
    }
}
