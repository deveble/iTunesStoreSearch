//
//  LoadingResultCell.swift
//  ItunesStore
//
//  Created by User on 2/21/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit

class LoadingResultCell: UITableViewCell {

    var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        title.textColor = .black
        title.textAlignment = .center
        title.text = "Loading..."
        
        return title
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(title)
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        title.heightAnchor.constraint(equalToConstant: 23).isActive = true
    
        contentView.addSubview(activityIndicator)
        activityIndicator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
