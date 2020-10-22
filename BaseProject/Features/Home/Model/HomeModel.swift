//
//  HomeModel.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/21/20.
//  Copyright © 2020 F99. All rights reserved.
//

import Foundation

struct HomeModel {
    var id: Int
    var title: String
    var image: String
    var data: [CatalogModel]
    
    init(id: Int, title: String, image: String, data: [CatalogModel]) {
        self.id = id
        self.title = title
        self.image = image
        self.data = data
    }
}

extension HomeModel: Equatable {
    static func ==(lhs: HomeModel, rhs: HomeModel) -> Bool {
        return lhs.id == rhs.id
    }
}
