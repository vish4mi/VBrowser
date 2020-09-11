//
//  BottomSheetTableViewCell.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 11/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class BottomSheetTableViewCell: UITableViewCell {

    @IBOutlet weak var engineImageView: UIImageView!
    @IBOutlet weak var engineTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        engineImageView.image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        engineTitleLabel.text = ""
    }
    
    func setupCell(withImageName imageName: String, andTitle title: String) {
        engineImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        engineTitleLabel.text = title
    }
    
}
