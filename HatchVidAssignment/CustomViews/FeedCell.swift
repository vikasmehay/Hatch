//
//  FeedCell.swift
//  HatchVidAssignment
//
//  Created by Vikas Mehay on 2025-09-04.
//

import UIKit
import AVFoundation

class FeedCell: UICollectionViewCell {
    static let reuseIdentifier = "FeedCell"
    @IBOutlet weak var imgPlaceholder: UIImageView!
    
    var playerLayer: AVPlayerLayer?
    var player : AVPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPlaceholder.center = contentView.center
//        self.player = AVPlayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
//    MARK: Custom Methods
    func setupCellFor(url : URL) {
        self.reset()
        
        self.player = AVPlayer(url: url)
        self.player?.actionAtItemEnd = .none
        
        self.playerLayer = AVPlayerLayer(player: player)
        self.playerLayer?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        print(self.playerLayer?.frame)
        self.playerLayer?.videoGravity = .resizeAspectFill
        
        if let layer = playerLayer {
            contentView.layer.addSublayer(layer)
        }
        player?.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func togglePlay() {
        player?.isPlaying ?? false ? player?.pause() : player?.play()
    }
    
    func reset() {
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func playerDidFinishPlaying() {
        player?.seek(to: .zero)
        player?.play()
    }
}
