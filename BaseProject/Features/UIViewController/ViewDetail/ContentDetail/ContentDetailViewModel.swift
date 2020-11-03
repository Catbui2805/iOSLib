//
//  ContentDetailViewModel.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/23/20.
//  Copyright © 2020 F99. All rights reserved.
//

import Foundation

public typealias ContentItem = (label: String, value: String?, isUrl: Bool)

class ContentDetailViewModel {
    private let object: CatalogItemModel
    
    private var content: [ContentItem] = []
    init(catalogModel object: CatalogItemModel) {
        self.object = object
        content.append(ContentItem("Title", object.title, false))
        content.append(ContentItem("Lib Type", object.libType.rawValue, false))
        content.append(ContentItem("Description", object.desc, false))
        content.append(ContentItem("Image", object.image, false))
        content.append(ContentItem("URL Referent", object.urlReferent, true))
        content.append(ContentItem("URL Git", object.urlGit, true))
        content.append(ContentItem("URL Document", object.urlDoc, true))
    }
    
    func getContent() -> [ContentItem] {
        return content
    }
    
    func numberOfRowInSection() -> Int {
        return content.count
    }
    
    func selectedItemAt(_ index: Int) -> ContentItem? {
        if index < content.count {
            return content[index]
        } else {
            return nil
        }
    }
    
}
