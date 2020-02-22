//
//  EmptyResultCell.swift
//  ItunesStore
//
//  Created by User on 2/21/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit

class EmptyResultCell: UITableViewCell {

    var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        title.textColor = .darkGray
        title.text = "No Result..."
        title.textAlignment = .center
        
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        title.backgroundColor = backgroundColor
        contentView.addSubview(title)
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
