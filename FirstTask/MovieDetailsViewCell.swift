import UIKit

class MovieDetailsViewCell: UITableViewCell {
    
    @IBOutlet var myTitle : UILabel!
    @IBOutlet var myImage : UIImageView!
    @IBOutlet var myOverView : UILabel!
    @IBOutlet var myVoteCount : UILabel!
    
    static let identifier = "MovieDetailsViewCell"
    
    func mySetup(with movie: MovieModel) {
//        let urlString =  "https://image.tmdb.org/t/p/w200\(movie.poster_path)"
        guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(movie.poster_path)") else { return  }
        
        let imageData = try? Data(contentsOf: url)
        myImage.image = UIImage(data: imageData!)
        myTitle.text = movie.title
        myOverView.text = movie.overview
        myVoteCount.text = String(movie.vote_count)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "MovieDetailsViewCell", bundle: nil)
    }
    
}
