//
//  Meme.swift
//  MemeMe
//
//  Created by Ballinger, Colton J. on 4/14/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var topText: String
    var bottomText: String
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}