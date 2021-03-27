import UIKit

protocol HomeCellDelegate: class {
    func onTapFavouriteButton(_ movie: Movie, isFavourite: Favorite?, indexPath: IndexPath?)
}

enum Favorite {
    case isFavourite
    case notFavorite
}

class HomeCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var yearOfProductionLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!

    weak var delegate: HomeCellDelegate?
    var indexPath: IndexPath?
    var movie: Movie?
    var isFavourite: Favorite?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        posterImageView.layer.cornerRadius = 8
    }

    func configureCell(_ movie: Movie) {
        self.movie = movie
        movieTitleLabel.text = movie.Title
        yearOfProductionLabel.text = movie.Year
        directorLabel.text = movie.Director
        posterImageView.sd_setImage(with: URL(string: movie.Poster ?? ""), placeholderImage: UIImage(), options: [.refreshCached, .continueInBackground, .progressiveLoad], completed: nil)
    }

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        if let movie = movie {
            delegate?.onTapFavouriteButton(movie, isFavourite: isFavourite, indexPath: indexPath)
        }
    }
}
