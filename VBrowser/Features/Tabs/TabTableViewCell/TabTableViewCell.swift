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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shouldAddShadow {
            addShadow()
        }
    }
    
    func configureCell() {
        tabContentView.layer.cornerRadius = 6.0
        tabContentView.layer.borderColor = UIColor.lightGray.cgColor
        tabContentView.layer.borderWidth = 1.0        
    }
    
    func addShadow() {
        tabContentView.dropShadow(with: .green)
        shouldAddShadow = true
    }
    
    func setupCell(withTitle title: String, andSubtitle subtitle: String) {
        if title.isEmpty {
            titleLabel.text = "New Tab"
            subtitleLabel.text = ""
        } else {
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
    }
}
