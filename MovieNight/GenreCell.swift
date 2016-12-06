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
        case let movie as Movie:
            if let url = movie.imageURL?.absoluteString {
                cellImage.setImageFromURl(stringImageUrl: url)
                if let title = movie.title {
                    self.cellLabel.text = title
                }
            }
        default:
            break
        }
    }
}

extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
