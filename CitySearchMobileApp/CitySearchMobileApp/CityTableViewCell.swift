//
//  CityTableViewCell.swift
//  CitySearchMobileApp
//
//  Created by Lance on 01/08/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var label_State: UILabel!
    @IBOutlet weak var label_Country: UILabel!
    @IBOutlet weak var label_City: UILabel!
    @IBOutlet weak var view_Background: UIView!
    
    var cityDetails: City? = nil {
        didSet {
            self.configureCellData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.view_Background.layer.borderColor = UIColor.link.cgColor
        self.view_Background.layer.borderWidth = 2
        self.view_Background.layer.cornerRadius = 10
        self.view_Background.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCellData() {
        self.label_State.text = self.cityDetails?.adminName1
        self.label_Country.text = self.cityDetails?.countryName
        self.label_City.text = self.cityDetails?.toponymName
    }

}
