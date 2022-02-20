//
//  SnapVC.swift
//  SnapchatFirebaseClone
//
//  Created by Macbook Air on 19.02.2022.
//

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {

    @IBOutlet weak var timeLeftLabel: UILabel!
    
    var selectedSnap : Snap?
    var selectedTime : Int?
    var inputArray = [KingfisherSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let time = selectedTime {
            timeLeftLabel.text = "Time left: \(time)"
        }
        
        if let snap = selectedSnap{
            for image in snap.imageUrlAray{
                inputArray.append(KingfisherSource(urlString: image)!)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.90))
            imageSlideShow.backgroundColor = UIColor.white
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            imageSlideShow.pageIndicator = pageIndicator
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLeftLabel)
            
            
            
        }
    
        
        
        
    }
    


}
