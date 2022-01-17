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
    var imageCache = ImageCache()
    var urlString: String?
    
    func setup(with movie: MovieModel) {
        urlString =  "https://image.tmdb.org/t/p/w200\(movie.poster_path)"
        loadImage()
        myLabel.text = movie.title
    }
    func loadImage() {
        if loadImageFromCache() {
            print("Cache hit")
            return
        }
        
        print("Cache miss, loading from url")
        loadImageFromUrl()
    }
    
    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
    
        guard let url = URL(string:urlString) else { return }
        let data = try? Data(contentsOf: url)

        guard let loadedImage = UIImage(data: data!) else {
            return
        }
        
        imageCache.set(forKey: urlString, image: loadedImage)
        myImageView.image = loadedImage
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        myImageView.image = cacheImage
        return true
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

}
