import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    public var viewModel: HomeViewModel? { didSet { bindViewModel() } }

    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        tableView.tableFooterView = UIView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        startAnimatingActivityIndicator()
        title = "Batman movies"
        registerNib()
        viewModel?.fetchMoviesFromCoredata()
        viewModel?.fetchMovies(delegate: self)
    }

    private func registerNib() {
        tableView.register(UINib(nibName: HomeCell.nibName, bundle: nil), forCellReuseIdentifier: HomeCell.reuseIdentifier)
    }

    private func startAnimatingActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func stopAnimatingActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

extension HomeViewController: HomeDelegate, HomeCellDelegate {
    func onGetMovies() {
        stopAnimatingActivityIndicator()
        guard let vm = viewModel else { return }
        if vm.movies.count > 0 {
            tableView.isHidden = false
            tableView.reloadData()
        } else {
            tableView.isHidden = true
        }
    }

    func onTapFavouriteButton(_ movie: Movie, isFavourite: Favorite?, indexPath: IndexPath?) {
        guard let indexPath = indexPath,
              let cell = tableView.cellForRow(at: indexPath) as? HomeCell,
              let isFavorite = cell.isFavourite,
              let vm = viewModel
                else { return }
        switch isFavorite {
        case .isFavourite:
            cell.isFavourite = .notFavorite
            vm.removeFromFavList(movie)
        case .notFavorite:
            cell.isFavourite = .isFavourite
            vm.addToFavList(movie)
        }
        let imageName = isFavourite == .isFavourite ? "no Favorite" : "Fovorite"
        cell.favouriteButton.setImage(UIImage(named: imageName), for: .normal)
    }

    func onError(_ message: String) {
        stopAnimatingActivityIndicator()
        showAlertDialog(title: "Error", message: message)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let vm = viewModel else { return }
        vm.filteredMoviesList = vm.movies.filter({ (movie: Movie) -> Bool in
            return (movie.Title?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        isSearching = true
        tableView.reloadData()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let count = searchBar.text?.count, count > 0 else {
            isSearching = false
            tableView.reloadData()
            return
        }
        isSearching = true
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        if isSearching {
            return vm.filteredMoviesList.count
        }
        return vm.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier) as? HomeCell, let vm = viewModel else { return UITableViewCell() }
        if isSearching {
            let movie = vm.filteredMoviesList[indexPath.row]
            if vm.favoriteMovies.contains(movie) {
                cell.favouriteButton.setImage(UIImage(named: "Fovorite"), for: .normal)
                cell.isFavourite = .isFavourite
            } else {
                cell.isFavourite = .notFavorite
                cell.favouriteButton.setImage(UIImage(named: "no Favorite"), for: .normal)
            }
            cell.configureCell(movie)
        } else {
            let movie = vm.movies[indexPath.row]
            if vm.favoriteMovies.contains(movie) {
                cell.isFavourite = .isFavourite
                cell.favouriteButton.setImage(UIImage(named: "Fovorite"), for: .normal)
            } else {
                cell.isFavourite = .notFavorite
                cell.favouriteButton.setImage(UIImage(named: "no Favorite"), for: .normal)
            }
            cell.configureCell(movie)
        }

        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vm = viewModel else { return }
        var movie: Movie?
        if isSearching {
            movie = vm.filteredMoviesList[indexPath.row]
        } else {
            movie = vm.movies[indexPath.row]
        }
        searchBar.searchTextField.text = ""
        searchBar.endEditing(true)
        let vc = HomeDetailViewController(nibName: "HomeDetailViewController", bundle: nil)
        vc.viewModel = vm
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
}
