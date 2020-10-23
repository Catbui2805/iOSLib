//
//  ContentDetailCell.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/23/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

class ContentDetailCell: UITableViewCell {
    lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var lbDesc: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .lightGray
        lb.numberOfLines = 0
        return lb
    }()
    
    var model: ContentItem? {
        didSet {
            lbTitle.text = model?.label
            lbDesc.text = model?.value
            if model?.isUrl ?? false {
                lbDesc.font = UIFont.systemFont(ofSize: 12)
                lbDesc.textColor = .blue
            } else {
                lbDesc.font = UIFont.systemFont(ofSize: 15)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentDetailCell {
    func setupViews() {
        setupLabelTitle()
        setupLabelDesc()
    }
    
    func setupLabelTitle() {
        addSubview(lbTitle)
        NSLayoutConstraint.activate([
            lbTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            lbTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            lbTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            lbTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }
    
    func setupLabelDesc() {
        addSubview(lbDesc)
        NSLayoutConstraint.activate([
            lbDesc.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 8),
            lbDesc.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lbDesc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            lbDesc.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            lbDesc.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
