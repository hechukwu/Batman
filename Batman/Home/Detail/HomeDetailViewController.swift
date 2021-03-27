import UIKit

class HomeDetailViewController: BaseViewController {

    @IBOutlet weak var posterImageview: UIImageView!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var yearOfProductionLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!

    public var viewModel: HomeViewModel? { didSet { bindViewModel() } }

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel?.fetchMovie(movie?.imdbID ?? "", delegate: self)
    }

    private func setupView() {
        title = movie?.Title
        yearOfProductionLabel.text = movie?.Year
        directorLabel.text = movie?.Director
        plotLabel.text = movie?.Plot
        posterImageview.sd_setImage(with: URL(string: movie?.Poster ?? ""), placeholderImage: UIImage(), options: [.refreshCached, .continueInBackground, .progressiveLoad], completed: nil)
    }
}

extension HomeDetailViewController: HomeDelegate {

    func onGetSingleMovie(_ movie: Movie?) {
        self.movie = movie
        setupView()
    }
}
