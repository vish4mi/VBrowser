//
//  TabTableViewCell.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 10/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class TabTableViewCell: UITableViewCell {

    @IBOutlet weak var tabContentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    var shouldAddShadow: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        shouldAddShadow = false
    }
    
    func configureCell() {
        tabContentView.layer.cornerRadius = 6.0
        tabContentView.layer.borderColor = UIColor.lightGray.cgColor
        tabContentView.layer.borderWidth = 1.0
        
        addObserver(self, forKeyPath: "tabContentView.bounds", options: .new, context: nil)
    }
    
    func addShadow() {
        tabContentView.dropShadow(with: .green)
        shouldAddShadow = true
    }
    
    func setupCell(withTitle title: String, andSubtitle subtitle: String) {
        if title.isEmpty {
            titleLabel.text = "New Tab"
        } else {
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
        layoutIfNeeded()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "tabContentView.bounds" {
            if shouldAddShadow {
                addShadow()
                shouldAddShadow = true
            }
        }
    }
}
