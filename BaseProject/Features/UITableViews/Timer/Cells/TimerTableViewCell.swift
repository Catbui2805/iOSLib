//
//  TimerTableViewCell.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/26/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbValue: UILabel!
    
    var data: TimerModel? {
        didSet {
            lbTitle.text = data?.title ?? ""
            lbValue.text = "\(data?.value ?? 0.0)"
        }
    }
    
    func udpateTime(_ index: Int) {
        lbValue.text = "\(index)s"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
