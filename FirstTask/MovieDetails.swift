//
//  MovieDetailViewController.swift
//  FirstTask
//
//  Created by abd on 11/01/2022.
//

import UIKit

class MovieDetailScrollingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var MyMovieModel : MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MovieDetailsViewCell.nib(), forCellReuseIdentifier: MovieDetailsViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
       

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsViewCell.identifier, for: indexPath) as! MovieDetailsViewCell
            cell.mySetup(with: MyMovieModel)
        return cell
    }
        
     
    

    
}
