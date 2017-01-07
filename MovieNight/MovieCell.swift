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
    @IBOutlet weak var loadingStatus: UIActivityIndicatorView!
    
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
    
    func displayImage(imageUrl: String){
        
        imageView?.image = nil
        if cellImage != nil && imageUrl != "" {
            print(imageUrl)
        } else {
            loadingStatus.isHidden = true
        }
    }
    
    func startLoading(){
        loadingStatus.isHidden = false
        loadingStatus.startAnimating()
    }
    
    func stopLoading(){
        loadingStatus.isHidden = true
        loadingStatus.stopAnimating()
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

