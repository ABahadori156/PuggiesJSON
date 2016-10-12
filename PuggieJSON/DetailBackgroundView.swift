//
//  DetailBackgroundView.swift
//  PuggieJSON
//
//  Created by Pasha Bahadori on 10/12/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit

class DetailBackgroundView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Each cell has a layer level where we can modify how it looks
        // layer.cornerRadius = 5.0
        shadow(view: self)
        roundedCorners(view: self)
        
        
    }
    
    func shadow(view: UIView) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        
        
    }
    
    func roundedCorners(view: UIView) {
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
