import UIKit

protocol HomeCellDelegate: class {
    func onTapFavouriteButton(_ movie: Movie, indexPath: IndexPath?)
}

class HomeCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var favouriteButton: UIButton!

    weak var delegate: HomeCellDelegate?
    var indexPath: IndexPath?
    var movie: Movie?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ movie: Movie) {
        self.movie = movie
    }

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        if let movie = movie {
            delegate?.onTapFavouriteButton(movie, indexPath: indexPath)
        }
    }
}
