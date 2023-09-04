//
//  FavoriteTableViewCell.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var lblPostId: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblBody:  UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
