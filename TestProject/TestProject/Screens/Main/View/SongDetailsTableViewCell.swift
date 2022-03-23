//
//  SongDetailsTableViewCell.swift
//  TestProject
//
//  Created by Jignesh's Mac on 26/06/21.
//

import UIKit

class SongDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var artIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.setupCardView()
        artIconImageView.cornerRadius()
    }
    
    func configureData(songDetail: SongDetails) {
        if let trackName = songDetail.trackName {
            trackNameLabel.text = trackName
        }
        
        if let artistName = songDetail.artistName {
            artistNameLabel.text = artistName
        }
        
        if let artWorkUrl = songDetail.artworkUrl100 {
            self.artIconImageView.setImage(imageUrl: artWorkUrl.toUrl())
        }
    }
}
