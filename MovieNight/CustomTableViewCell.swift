//
//  CustomTableViewCell.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 21/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.cellImageView.image = nil
    }
    
    //MARK: Cell config
    func configureCellWithMovie(_ movieType: MovieType) {
        switch movieType {
        case let person as Actor:
            
            if let url = person.profileImageURL {
                
                if let name = person.name {
                    self.cellLabel.text = name
                }
            }
        default:
            <#code#>
        }
    }

}
