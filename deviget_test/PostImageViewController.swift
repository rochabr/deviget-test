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
    var currentImage: UIImage = UIImage()
    
    @IBOutlet weak var PostImageView: UIImageView!
    
    override func viewDidLoad() {    
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let imageURL: NSURL = NSURL(string: imageURLString)!
        let imageData: NSData = NSData(contentsOfURL: imageURL)!
        
        currentImage = UIImage(data: imageData)!
        PostImageView.image = currentImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveImageToCameraRoll(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(currentImage, self,
            #selector(PostImageViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        if error != nil {
            let alert = UIAlertController(title: "Error", message:"The image wasn't saved, please allow the app to access your camera and album", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}

        }else{
            let alert = UIAlertController(title: "Image saved!", message:"You can find your image in your camera roll", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
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
