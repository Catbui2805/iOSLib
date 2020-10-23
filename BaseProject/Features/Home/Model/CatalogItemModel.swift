//
//  CatalogItemModel.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/22/20.
//  Copyright © 2020 F99. All rights reserved.
//

import Foundation

enum LibType: String, CaseIterable {
    case UIKIT = "UIKit"
    case SWIFTUI = "SwiftUI"
    case WKWEBVIEW = "WKWebView"
    case FOUNDATION = "Foundation"
}

enum ElementType: String, CaseIterable {
    case UIVIEW = "UIView"
    case UIVIEWCONTROLLER = "UIViewController"
}

struct CatalogItemModel {
    var id: String
    var title: String
    var libType: LibType
    var desc: String?
    var image: String?
    var urlReferent: String?
    var urlGit: String?
    var urlDoc: String?
    
    init(id: String, title: String, type: LibType) {
        self.id = id
        self.title = title
        self.libType = type
    }
    
    init(id: String, title: String, type: LibType, desc: String?, image: String?, urlReferent: String?, urlGit: String, urlDoc: String) {
        self.id = id
        self.title = title
        self.desc = desc
        self.image = image
        self.urlReferent = urlReferent
        self.libType = type
        self.urlGit = urlGit
        self.urlDoc = urlDoc
    }
}

extension CatalogItemModel: Equatable {
    static func ==(lhs: CatalogItemModel, rhs: CatalogItemModel) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.libType.rawValue == rhs.libType.rawValue
    }
}
