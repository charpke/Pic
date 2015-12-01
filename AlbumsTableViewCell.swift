//
//  AlbumsTableViewCell.swift
//  Albums
//
//  Created by Chuck Harpke on 11/29/15.
//  Copyright © 2015 Chuck Harpke. All rights reserved.
//
import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumCount: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

