//
//  DetailJobTitleCell.swift
//  Stitched App
//
//  Created by Com on 18/01/2017.
//  Copyright © 2017 Com. All rights reserved.
//

import UIKit

class DetailJobTitleCell: UITableViewCell {
	
	static var id = "DetailJobTitleCell"

	@IBOutlet weak var lblTitle: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
