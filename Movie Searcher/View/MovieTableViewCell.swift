//
//  MovieTableViewCell.swift
//  Movie Searcher
//
//  Created by naruto kurama on 28.04.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let idenfier = "MovieTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    func configure(with model : Movie) {
        movieTitleLabel.text = model.Title
        movieYearLabel.text = model.Year
        
        let url = model.Poster
        if let data = try? Data(contentsOf: URL(string: url)!) {
            moviePosterImageView.image = UIImage(data: data)
        }
        
    }
    
}
