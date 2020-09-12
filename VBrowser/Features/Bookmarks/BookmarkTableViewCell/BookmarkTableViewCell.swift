//
//  BookmarkTableViewCell.swift
//  VBrowser
//
//  Created by Vishal Bhadade on 10/09/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var bookmarkContentView: UIView!
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCell() {
        bookmarkContentView.layer.cornerRadius = 6.0
        bookmarkContentView.layer.borderColor = UIColor.lightGray.cgColor
        bookmarkContentView.layer.borderWidth = 1.0
        
        bookmarkContentView.dropShadow(with: nil)
        addObserver(self, forKeyPath: "bookmarkContentView.bounds", options: .new, context: nil)
    }
    
    func setupCell(withTitle title: String, andSubtitle subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bookmarkContentView.bounds" {
            bookmarkContentView.dropShadow(with: nil)
        }
    }
}
