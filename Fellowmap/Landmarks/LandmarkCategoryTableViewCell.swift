//
//  LandmarkCategoryTableViewCell.swift
//  Fellowmap
//
//  Created by Nathan Jacobs on 5/17/20.
//  Copyright © 2020 Nathan Jacobs. All rights reserved.
//

import UIKit

class LandmarkCategoryTableViewCell: UITableViewCell {

	//MARK: Properties
	@IBOutlet weak var  nameLabel: UILabel!
	@IBOutlet weak var showSwitch: UISwitch!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
