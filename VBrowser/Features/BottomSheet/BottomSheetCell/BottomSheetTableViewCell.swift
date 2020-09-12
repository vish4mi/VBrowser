//
//  BottomSheetTableViewCell.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 11/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class BottomSheetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bottomSheetContentView: UIView!
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomSheetContentView.dropShadow(with: nil)
    }
    
    func configure() {
        bottomSheetContentView.layer.cornerRadius = 6.0
        bottomSheetContentView.layer.borderColor = UIColor.lightGray.cgColor
        bottomSheetContentView.layer.borderWidth = 1.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        engineImageView.image = UIImage(named: "")
        engineTitleLabel.text = ""
    }
    
    func setupCell(withImageName imageName: String, andTitle title: String) {
        engineImageView.image = UIImage(named: imageName)
        engineTitleLabel.text = title
    }
    
}
