//
//  PugDetailImageView.swift
//  PuggieJSON
//
//  Created by Pasha Bahadori on 10/12/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit

class PugDetailImageView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Each cell has a layer level where we can modify how it looks
        layer.cornerRadius = 5.0
        shadow(imageView: self)
        roundedCorners(imageView: self)
        
    }
    
    func shadow(imageView: UIImageView) {
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 8
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.5
        
        
    }
    
    func roundedCorners(imageView: UIImageView) {
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
    }

}
