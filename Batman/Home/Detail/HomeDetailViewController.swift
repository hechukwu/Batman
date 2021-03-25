import UIKit

class HomeDetailViewController: BaseViewController {

    public var viewModel: HomeViewModel? { didSet { bindViewModel() } }

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
