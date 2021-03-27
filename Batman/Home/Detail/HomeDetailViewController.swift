import UIKit

class HomeDetailViewController: BaseViewController {

    @IBOutlet weak var posterImageview: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var yearOfProductionLabel: UILabel!

    public var viewModel: HomeViewModel? { didSet { bindViewModel() } }

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = movie?.Title
        posterImageview.sd_setImage(with: URL(string: movie?.Poster ?? ""), placeholderImage: UIImage(), options: [.refreshCached, .continueInBackground, .progressiveLoad], completed: nil)
    }
}
