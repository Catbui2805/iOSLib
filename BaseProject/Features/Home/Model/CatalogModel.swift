//
//  CatalogModel.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/22/20.
//  Copyright © 2020 F99. All rights reserved.
//

import Foundation

enum CatagoryType: String, CaseIterable {
    case ALL = "All"
    case SWIFT = "Swift"
    case POD = "Pod"
    case EXAMPLE = "Example"
}

struct CatalogModel {
    var id: Int
    var title: String
    var catalogType: CatagoryType
    var data: [CatalogItemModel]?
    var desc: String?
    var image: String?
    var url: String?
    var date: Date?
    
    init(id: Int, title: String, catalogType: CatagoryType) {
        self.id = id
        self.title = title
        self.catalogType = catalogType
    }
}

extension CatalogModel {
    static func ==(lhs: CatalogModel, rhs: CatalogModel) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.catalogType.rawValue == rhs.catalogType.rawValue
    }
}
