//
//  TodoListItemTableViewCell.swift
//  Todoapp
//
//  Created by Katsuya yamamoto on 2015/12/13.
//  Copyright (c) 2015年 nyalix. All rights reserved.
//

import UIKit

class DoneListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
