//
//  TrackTableViewCell.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var primaryGenreName: UILabel!
    
    lazy var currencyFormatter: NumberFormatter = {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .currency
        numFormatter.currencySymbol = Locale.current.currencySymbol
        numFormatter.usesGroupingSeparator = true
        return numFormatter
    }()

    lazy var cellReleaseDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ track: Track) {
        artistName.text = track.artistName ?? "Artist NA"
        trackName.text = track.trackName ?? "Track NA"
        if let price = track.trackPrice {
            trackPrice.text = "\(currencyFormatter.string(from: NSNumber(value: price)) ?? "0.0")"
        } else {
            trackPrice.text = "Price NA"
        }
        if let relDate = track.releaseDate {
            releaseDate.text = cellReleaseDateFormatter.string(from: relDate)
        } else {
            releaseDate.text = "Release Date NA"
        }
        primaryGenreName.text = track.primaryGenreName ?? "Genre NA"
    }


}
