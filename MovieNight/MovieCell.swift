//
//  CustomTableViewCell.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 21/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

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
    }
    
    //MARK: Cell config
    func configureCellWithMovie(_ movieType: MovieType) {
        
        switch movieType {
        case is Genre:
            break
        case let movie as Movie:
            if let title = movie.title {
                self.cellLabel.text = title
            }
        default:
            break
        }
    }

}

