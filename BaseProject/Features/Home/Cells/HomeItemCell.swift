//
//  HomeItemCell.swift
//  BaseProject
//
//  Created by Nguyen Tran on 10/21/20.
//  Copyright © 2020 F99. All rights reserved.
//

import UIKit

class HomeItemCell: UITableViewCell {
    lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        return lb
    }()
    
    lazy var lbDesc: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = .lightGray
        lb.numberOfLines = 0
        return lb
    }()
    
    var model: CatalogItemModel? {
        didSet {
            lbTitle.text = model?.title
            lbDesc.text = model?.desc
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

extension HomeItemCell {
    func setupViews() {
        setupLabelTitle()
        setupLabelDesc()
    }
    
    func setupLabelTitle() {
        addSubview(lbTitle)
        NSLayoutConstraint.activate([
            lbTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            lbTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            lbTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            lbTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
    
    func setupLabelDesc() {
        addSubview(lbDesc)
        NSLayoutConstraint.activate([
            lbDesc.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 8),
            lbDesc.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            lbDesc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            lbDesc.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            lbDesc.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
