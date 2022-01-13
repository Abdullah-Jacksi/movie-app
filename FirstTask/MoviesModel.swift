//
//  MoviesModel.swift
//  FirstTask
//
//  Created by abd on 11/01/2022.
//

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

//    let star : String
}


//struct Movie {
//    let title: String
//    let image: UIImage
//}
//
//let movies: [Movie] = [
//    Movie(title: "Hightown", image: #imageLiteral(resourceName: "hightown.png")),
//    Movie(title: "Penny Dreadful", image: #imageLiteral(resourceName: "pennyDreadful")),
//    Movie(title: "The Bold Type", image: #imageLiteral(resourceName: "boldType")),
//    Movie(title: "Blindspot", image: #imageLiteral(resourceName: "blindspot")),
//    Movie(title: "In the Dark", image: #imageLiteral(resourceName: "inTheDark")),
//    Movie(title: "Doom Patrol", image: #imageLiteral(resourceName: "doomPatrol.png")),
//    Movie(title: "Agents of S.H.I.E.L.D", image: #imageLiteral(resourceName: "agentsOfShield.png")),
//    Movie(title: "The 100", image: #imageLiteral(resourceName: "theHundred")),
//    Movie(title: "DC Legends of Tomorrow", image: #imageLiteral(resourceName: "dcLegendsOfTomorrow")),
//    Movie(title: "Siren", image: #imageLiteral(resourceName: "siren"))
//]
