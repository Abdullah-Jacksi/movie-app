//
//  MovieDetailViewController.swift
//  FirstTask
//
//  Created by abd on 11/01/2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var myImage : UIImageView!
    @IBOutlet var mytitle : UILabel!
    @IBOutlet var myDescription : UILabel!
    @IBOutlet var myVoteCount : UILabel!
    
    var name : String!
    var overview : String!
    var vote_count : Int!
    var image : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(image!)") else { return  }
        let imageData = try? Data(contentsOf: url)
        myImage.image = UIImage(data: imageData!)
        mytitle.text = name!
        myDescription.text = overview!
        myVoteCount.text = String(vote_count!)
    }
}
