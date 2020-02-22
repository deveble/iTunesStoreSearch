//
//  SearchResultCell.swift
//  ItunesStore
//
//  Created by User on 2/21/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    var icon: UIImageView = {
        var icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 8
        icon.layer.masksToBounds = true
        icon.image = UIImage(named: "image-placeholder")
        
        return icon
    }()
    
    var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        title.textColor = .black
        
        return title
    }()
    
    var subtitle: UILabel = {
        var subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.font = UIFont.systemFont(ofSize: 16)
        subtitle.textColor = .darkGray
        
        return subtitle
    }()
    
    var downloadTask: URLSessionDownloadTask?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        title.backgroundColor = backgroundColor
        icon.backgroundColor = backgroundColor
        
        contentView.addSubview(icon)
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        contentView.addSubview(title)
        title.topAnchor.constraint(equalTo: icon.topAnchor, constant: 0).isActive = true
        title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        contentView.addSubview(subtitle)
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        subtitle.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        icon.image = UIImage(named: "image-placeholder")
        title.text = ""
        subtitle.text = ""
        
        downloadTask?.cancel()
        downloadTask = nil
    }

    func configure(for result: SearchResult) {
        
        title.text = result.name
        if result.artist.isEmpty {
            subtitle.text = "Unknown"
        } else {
            subtitle.text = String(format: "%@, %@", result.artist, result.type) 
        }
        
        if let iconURL = URL(string: result.imageSmall) {
            downloadTask = icon.loadImage(url: iconURL)
        }
    }
}
