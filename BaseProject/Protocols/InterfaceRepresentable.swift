//
//  InterfaceRepresentable.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/21/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

protocol InterfaceRepresentable: class {
    static var classId: String { get }
    var classId: String { get }
    static var nib: UINib { get }
}

extension InterfaceRepresentable {
    static var classId: String {
        return String(describing: self.self)
    }
    
    var classId: String {
        return String(describing: type(of: self))
    }
    
    static var nib: UINib {
        return UINib(nibName: classId, bundle: nil)
    }
}
