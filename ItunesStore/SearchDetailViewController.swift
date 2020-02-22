//
//  SearchDetailViewController.swift
//  ItunesStore
//
//  Created by User on 2/21/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit
import PanModal

class SearchDetailViewController: UIViewController, PanModalPresentable {
    
    // MARK: - Properties
    let result: SearchResult
    var downloadTask: URLSessionDownloadTask?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Views
    var icon: UIImageView = {
        var icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 8.0
        icon.layer.masksToBounds = true
        icon.image = UIImage(named: "image-placeholder")
        
        return icon
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let priceButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 34)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Initializers
    init(result: SearchResult) {
        self.result = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = result.name
        view.backgroundColor = .white
        
        setupConstraints()
        updateUI()
    }
    
    deinit {
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    // MARK: - Layoutt
    fileprivate func setupConstraints() {
        view.addSubview(icon)
        icon.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        icon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: view.topAnchor, constant: 25.0).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [typeLabel, genreLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 24.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        
        view.addSubview(roleLabel)
        roleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4.0).isActive = true
        roleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        roleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        
        view.addSubview(priceButton)
        priceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        priceButton.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 24.0).isActive = true
        priceButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: priceButton.bottomAnchor).isActive = true
        
    }
    
    fileprivate func updateUI(){
        
        nameLabel.text = result.name
        roleLabel.text = String(format: "Artist: %@", result.artist)
        typeLabel.text = String(format: "Kind: %@", (result.kind ?? "N/A"))
        genreLabel.text = String(format: "Genre: %@", result.genre)
        if result.price == 0 {
            priceButton.setTitle("Free", for: .normal)
        } else {
            priceButton.setTitle(String(format: "$%.2f", result.price), for: .normal)
        }
        if let iconURL = URL(string: result.imageLarge) {
            downloadTask = icon.loadImage(url: iconURL)
        }
    }
    
    // MARK: - Pan Modal Presentable
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .intrinsicHeight
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var shouldRoundTopCorners: Bool {
        return true
    }
    
}
