//
//  TabTableViewCell.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 10/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class TabTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(withTitle title: String, andSubtitle subtitle: String) {
        if title.isEmpty {
            titleLabel.text = "New Tab"
            subtitleLabel.text = ""
        } else {
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
