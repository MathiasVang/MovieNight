//
//  GenreCell.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 06/12/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import UIKit
import AlamofireImage

class GenreCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.cellImage.image = nil
    }
    
    //MARK: Cell config
    func configureCellWithGenre(_ movieType: MovieType) {
        
        switch movieType {
        case let genre as Genre:
            
            if let name = genre.name {
                self.cellLabel.text = name
            }
        case is Movie:
            break
        default:
            break
        }
    }
}

