//
//  PugDetailVC.swift
//  PuggieJSON
//
//  Created by Pasha Bahadori on 10/10/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit
import SDWebImage

class PugDetailVC: UIViewController {

    var pugsArray = [Pug]()
    var pugIndex: Int!
    @IBOutlet weak var pugDetailImageVuew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pugUnit = pugsArray[pugIndex]
        
        pugDetailImageVuew.sd_setImage(with: pugUnit.pugPicURL)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissPugDetail(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func dismissDetailVC(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
