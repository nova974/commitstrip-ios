//
//  CommitCellTableViewCell.swift
//  CsApp
//
//  Created by William Gossard on 09/01/2017.
//  Copyright © 2017 William Gossard. All rights reserved.
//

import UIKit

class CommitCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleField: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
