//
//  TimerModel.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/26/20.
//  Copyright © 2020 F99. All rights reserved.
//

import Foundation

struct TimerModel {
    var id: Int
    var title: String
    var value: Double
    
    init(id: Int, title: String, value: Double) {
        self.id = id
        self.title = title
        self.value = value
    }
}
