import Foundation



struct MoviesModel: Decodable {
    
    let results: [MovieModel]

}

struct MovieModel : Decodable {
    let poster_path : String
    let title : String
    let overview : String
    let vote_count : Int
    let id : Int
}
