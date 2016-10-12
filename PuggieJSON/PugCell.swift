//
//  PugCell.swift
//  PuggieJSON
//
//  Created by Pasha Bahadori on 9/25/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit

protocol PugCellDelegate {
    func pugCellImage(sender: PugCell, imageView: UIImage)
}

class PugCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var delegate: PugCellDelegate?
    
    @IBOutlet weak var pugURL: UILabel!
    @IBOutlet weak var pugImageView: UIImageView!
    
    var pasteboard = UIPasteboard()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        longPress()
        pasteboard = UIPasteboard.general
        //TAPGESTURE RECOGNIZER FOR LIKES
      

  
    }
    
    //ROUNDING THE CELL'S BORDER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Each cell has a layer level where we can modify how it looks
        layer.cornerRadius = 5.0
      
        

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
    
    
    
    //GESTURE RECOGNIZERS
    func longPress() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(pugImageViewCopiedTapped))
        longTap.minimumPressDuration = 0.8
        longTap.delaysTouchesBegan = true
        pugImageView.addGestureRecognizer(longTap)
        pugImageView.isUserInteractionEnabled = true
    }
    
    //METHODS OF GESTURE RECOGNIZERS
    func pugImageViewCopiedTapped(sender: UILongPressGestureRecognizer) {
        pasteboard.image = pugImageView.image
        
        print("PugImageView is copied")
    }
}
