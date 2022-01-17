//
//  NetworkBrain.swift
//  FirstTask
//
//  Created by abd on 12/01/2022.
//

import Foundation


class NetworkBrain {
    
    var pageNumber : Int = 1
    
    func getMoviesList (compation: @escaping (Result<[MovieModel],Error> ) -> Void){
        let stringURL : String! = "https://api.themoviedb.org/3/movie/popular?language=enUS&api_key=fd2b04342048fa2d5f728561866ad52a&page=\(pageNumber)"
        guard let stringURL = stringURL else {
            print("there is an error in url")
            return
        }
        
        let url = URL(string: stringURL)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url! , completionHandler: { data, response, error in
            if  error != nil {
                print("there is an error in get dat \(error!.localizedDescription)")
                compation(.failure(error!))
                return
            }
            
            if let safeData = data {
                
                do{
                    let result = try JSONDecoder().decode(MoviesModel.self, from: safeData)
                    compation(.success(result.results ))
                    
                }catch{
                    print("there is an error : \(error.localizedDescription)")
                }
                
            }
            
        })
        
        task.resume()
        
    }
    
}
