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

//private func getMovieDetails (){
//    let s = "https://api.themoviedb.org/3/movie/\(id)?language=enUS&api_key=fd2b04342048fa2d5f728561866ad52a"
//    let url = URL(string: s)
//    
//    guard url != nil else {
//        print("there is an error in url")
//        return
//    }
//    
//    let session = URLSession(configuration: .default)
//    
//    
//    let task = session.dataTask(with: url! , completionHandler: { data, response, error in
//        if  error != nil {
//            print("there is an error in get dat \(error!.localizedDescription)")
//            return
//        }
//        
//        if let safeData = data {
//            
//            do{
//                let result = try JSONDecoder().decode(MovieModel.self, from: safeData)
////                    print(result.results)
//              
//                DispatchQueue.main.async{
////                        self.movies = result;
//                    print(result.title)
//                    print("movie.title")
//                    guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(result.poster_path)") else { return  }
//                    let data = try? Data(contentsOf: url)
//
//                    self.myImage.image = UIImage(data: data!)
//                    self.mytitle.text = result.title
//                    self.myDescription.text = result.overview
//                    self.myVoteCount.text = String(result.vote_count)
//
//                }
//               
//            }catch{
//                print("there is an error : \(error.localizedDescription)")
//            }
//    
//        }
//       
//    })
//    
//    task.resume()
//    
//    
//}
