//
//  Extensions.swift
//  HatchVidAssignment
//
//  Created by Vikas Mehay on 2025-09-04.
//

import Foundation
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
