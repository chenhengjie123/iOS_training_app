//
//  ProductCell.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 7/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {



    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
