import UIKit

final class ImagesListCell: UITableViewCell {
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    static let reuseIdentifier = "ImagesListCell"
}
