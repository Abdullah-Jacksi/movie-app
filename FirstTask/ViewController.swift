import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [MovieModel]()
    var filteredMovies = [MovieModel]()
    var networkBrain = NetworkBrain()
    let searchControler = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        searchControler.searchResultsUpdater = self
        searchControler.obscuresBackgroundDuringPresentation = false
        searchControler.searchBar.placeholder = "Search for your movie"
        navigationItem.searchController = searchControler
        searchControler.searchBar.enablesReturnKeyAutomatically = false
        
        networkBrain.getMoviesList { [weak self] res in
            switch (res){
            case.success(let data):
                self?.movies = data
                DispatchQueue.main.async {
                    
                    self?.collectionView.reloadData()
                }
            case .failure(_):
                return
            }
        }
    }
    
    func getMoreMovies () {
        networkBrain.pageNumber = networkBrain.pageNumber + 1
        networkBrain.getMoviesList { [weak self] res  in
            switch (res){
            case.success(let data):
                self?.movies.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(_):
                return
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        imageCachManger.imageKeys.count
        if self.searchControler.isActive {
            return self.filteredMovies.count
        }else{
            return self.movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        if self.searchControler.isActive {
            cell.setup(with: filteredMovies[indexPath.row])
        } else {
            cell.setup(with: movies[indexPath.row])
            
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 5, height: 300)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == movies.count - 2){
            getMoreMovies ()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "MovieDetailScrollingViewController") as! MovieDetailScrollingViewController
        
        vc.MyMovieModel = movies[indexPath.row]
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
    }
}


extension ViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{
            return
        }
        print(text)
        filteredMovies.removeAll()
        
        for (_, element) in movies.enumerated() {
            if(element.title.lowercased().contains(text.lowercased())){
                filteredMovies.append(element)
            }
        }
        
        self.collectionView.reloadData()
    }
}
