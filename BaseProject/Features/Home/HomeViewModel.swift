//
//  HomeViewModel.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/21/20.
//  Copyright © 2020 F99. All rights reserved.
//

import Foundation

struct HomeViewModel {
    private let homeModel: HomeModel
    private let content: [CatalogModel]
    
    init() {
        var data: [CatalogModel] = []
        
        var swift = CatalogModel(id: 2, title: CatagoryType.SWIFT.rawValue, catalogType: .SWIFT)
        var swiftData: [CatalogItemModel] = []
        for index in 11...20 {
            var value = CatalogItemModel(id: index, title: "\(index) -ui view controller", type: .UIKIT)
            value.desc = "ui view controller CatalogItemModel(id: index, title:  type: .UIKIT)"
            swiftData.append(value)
        }
        swift.data = swiftData
        data.append(swift)
        
        var pod = CatalogModel(id: 3, title: CatagoryType.POD.rawValue, catalogType: .POD)
        var podData: [CatalogItemModel] = []
        for index in 21...30 {
            var value = CatalogItemModel(id: index, title: "\(index) -lib pod", type: .UIKIT)
            value.desc = "lib pod CatalogItemModel(id: index, title:  type: .UIKIT)"
            podData.append(value)
        }
        pod.data = podData
        data.append(pod)
        
        var example = CatalogModel(id: 4, title: CatagoryType.EXAMPLE.rawValue, catalogType: .EXAMPLE)
        var exData: [CatalogItemModel] = []
        for index in 31...40 {
            var value = CatalogItemModel(id: index, title: "\(index) -custom view", type: .UIKIT)
            value.desc = "custom view CatalogItemModel(id: index, title:  type: .UIKIT)"
            exData.append(value)
        }
        example.data = exData
        data.append(example)
        
        // MARK: - UIView
        
        // MARK: - UIViewController
        

        let model = HomeModel(id: 0, title: Constants.String.homeTitle, image: "", data: data)
        homeModel = model
        content = data
    }
    
    func getHomeModel() -> HomeModel {
        return homeModel
    }
    
    func getContent() -> [CatalogModel] {
        return content
    }
    
    func sectionOfContent() -> Int {
        return 2
    }
    
    func numberOfSections() -> Int {
        return content.count
    }
    
    func getValueAt(_ index: Int) -> CatalogModel? {
        if index < content.count {
            return content[index]
        } else {
            return nil
        }
    }
}

// MARK: - Filter type
extension HomeViewModel {
    
}
