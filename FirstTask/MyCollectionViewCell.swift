//
//  MyCollectionViewCell.swift
//  FirstTask
//
//  Created by abd on 10/01/2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var myImageView : UIImageView!
    @IBOutlet var myLabel : UILabel!
    
    static let identifier = "MyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with movie: MovieModel) {
        print(movie.title)
        print("movie.title")
        guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(movie.poster_path)") else { return  }
        let data = try? Data(contentsOf: url)

        myImageView.image = UIImage(data: data!)
        myLabel.text = movie.title
    }
    
    
    
//    public func setup (with image : UIImage , with label : UILabel){
//        myImageView.image = image
//        myLabel.text = label.text
//    }
    
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

}
