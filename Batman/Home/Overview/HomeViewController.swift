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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "Batman movies"
        registerNib()
    }

    private func registerNib() {
        tableView.register(UINib(nibName: HomeCell.nibName, bundle: nil), forCellReuseIdentifier: HomeCell.reuseIdentifier)
    }
}

extension HomeViewController: HomeDelegate, HomeCellDelegate {
    func onGetMovies() {
        guard let vm = viewModel else { return }
        if vm.movies.count > 0 {
            tableView.reloadData()
        } else {
            tableView.isHidden = true
        }
    }

    func onTapFavouriteButton(_ movie: Movie, indexPath: IndexPath?) {
        <#code#>
    }

    func onError(message: String) {
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
        return vm.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier) as? HomeCell, let vm = viewModel else { return UITableViewCell() }
        let movie = vm.movies[indexPath.row]
        cell.configureCell(movie)
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
        let movie = vm.movies[indexPath.row]
        searchBar.searchTextField.text = ""
        searchBar.endEditing(true)
        let vc = HomeDetailViewController(nibName: "HomeDetailViewController", bundle: nil)
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
}
