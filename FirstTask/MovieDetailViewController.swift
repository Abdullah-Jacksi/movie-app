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
    
    var id : Int = 0
    var networkBrain = NetworkBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        networkBrain.getMovieDetails (id: self.id,compation: { [weak self] res in
            switch (res){
            case.success(let result):
                DispatchQueue.main.async{
    //                        self.movies = result;
                    print(result.title)
                    print("movie.title")
                    guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(result.poster_path)") else { return  }
                    let data = try? Data(contentsOf: url)

                    self?.myImage.image = UIImage(data: data!)
                    self?.mytitle.text = result.title
                    self?.myDescription.text = result.overview
                    self?.myVoteCount.text = String(result.vote_count)

                }
            
            case .failure(_):
                return
            }
            
        })
    }
    
   

}
