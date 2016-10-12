//
//  ViewController.swift
//  PuggieJSON
//
//  Created by Pasha Bahadori on 9/25/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var pugDetail: Pug!
    var scrollDidFinish = false
    
    // var pugsArray = [String]()
    var pugsArray = [Pug]()
    let pasteBoard = UIPasteboard()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        callAlamo(URL_PUG)
        self.collectionView.reloadData()
        // pugDetail.showJSON()
    }
    
    func callAlamo(_ url : String) {
        Alamofire.request(url).responseJSON { response in
            self.parseData(response.data!)
        }
    }
    
    func parseData(_ JSONData : Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [String : Any]
            if let pugs = readableJSON["pugs"] as? [String] {
                
                //Here I iterated through the parsed JSON and added the pugs URL Strings into my own pugsArray
                for i in 0..<pugs.count {
                    let pug = pugs[i]
                    
                    if let url = NSURL(string:pug) {
                        let pugDetail = Pug(pugPicURL: url as URL)
                        print(url)
                        pugsArray.append(pugDetail as Pug)
                    }
   
                }
                // print("ARRAY OF PUGS: \(pugsArray)")
            }
            self.collectionView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    //CACHING/LOADING IMAGE FUNCTION
    func setImageWithUrl(imageView:UIImageView,url:URL) {
        imageView.sd_setImage(with: url, placeholderImage: nil, options: [.lowPriority,.retryFailed]) { (image:UIImage?, error:Error?, cacheType:SDImageCacheType, url:URL?) in
            if cacheType == .none {
                imageView.alpha = 0
                UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseOut, animations: {
                    imageView.alpha = 1.0
                    }, completion: nil)
            }
        }
    }
    
    // create a custom class for the objects
    // LOAD PUGS TO COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PugCell", for: indexPath) as! PugCell
        
        let pugUnit = pugsArray[indexPath.row]
        
        //Set Images from pugsArray into the cell's imageView
        
        self.setImageWithUrl(imageView: cell.pugImageView, url: pugUnit.pugPicURL)
        // cell.pugImageView.sd_setImage(with: pugUnit.pugPicURL)
        
        
        cell.roundedCorners(imageView: cell.pugImageView)
        cell.shadow(imageView: cell.pugImageView)
        
        
        return cell
    }
    
    

    
    
    //SEGUE TO DETAILVC
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PugCell", for: indexPath) as! PugCell
        
        self.pasteBoard.image = cell.pugImageView.image
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "toPugDetail") as! PugDetailVC
        
        dvc.pugsArray = self.pugsArray
        dvc.pugIndex = indexPath.row
        self.present(dvc, animated: true, completion: nil)
        
        print("\(pasteBoard.image)")
    }
    
    
    //FUNCTION TO PARSE MORE PUGS WHEN REACHING THE END OF THE SCROLLVIEW
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset: CGPoint = scrollView.contentOffset
        let bounds: CGRect = scrollView.bounds
        let size: CGSize = scrollView.contentSize
        let inset: UIEdgeInsets = scrollView.contentInset
        let y = (offset.y) + (bounds.size.height) - (inset.bottom)
        // let h: Float = Float(size.height)
        let h: CGFloat = size.height
        let reloadDistance: CGFloat = 50
        
        if (scrollDidFinish == false) && (y > h + reloadDistance) {
            callAlamo(URL_PUG)
            self.collectionView.reloadData()
            scrollDidFinish = true
            print("Loaded more pugs")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pugsArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

   /*
    @IBAction func segueToPugDetail(_ sender: AnyObject) {
        let pugDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "toPugDetail") as! PugDetailVC
        self.performSegue(withIdentifier: "toPugDetailSegue", sender: AnyObject.self)
        
        print("SEGUETOPUGDETAIL USED")
        
    }
    */
 
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "toPugDetailsSegue" {
    //            print("Arrived at Pug Details VC")
    //        }
    //    }
    


    
    
}

