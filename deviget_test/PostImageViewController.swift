//
//  PostImageViewController.swift
//  deviget_test
//
//  Created by Fernando Rocha Silva on 3/25/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import UIKit

class PostImageViewController: UIViewController {

    var imageURLString: String = ""
    @IBOutlet weak var PostImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let imageURL: NSURL = NSURL(string: imageURLString)!
        let imageData: NSData = NSData(contentsOfURL: imageURL)!
        
        PostImageView.image = UIImage(data: imageData)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
