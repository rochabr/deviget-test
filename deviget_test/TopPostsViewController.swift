//
//  TopPostsViewController.swift
//  deviget_test
//
//  Created by Fernando Rocha Silva on 3/23/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import UIKit

class TopPostsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableData = []
    var selectedImageURL = ""
    @IBOutlet weak var redditListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getRedditJSON("https://www.reddit.com/r/all/top.json")
    }
    
    func getRedditJSON(whichReddit : String){
        let mySession = NSURLSession.sharedSession()
        let url: NSURL = NSURL(string: whichReddit)!
        let networkTask = mySession.dataTaskWithURL(url, completionHandler : {data, response, error -> Void in
            var theJSON: AnyObject
            
            do {
                theJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                let results : NSArray = theJSON["data"]!!["children"] as! NSArray
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableData = results
                    self.redditListTableView!.reloadData()
                })
            } catch {
                print("Something went wrong!")
            }
        })
        networkTask.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RedditTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RedditTableViewCell
        
        let redditEntry : NSMutableDictionary = self.tableData[indexPath.row] as! NSMutableDictionary
        
        cell.titleLabel!.text = redditEntry["data"]!["title"] as? String
        
        cell.authorLabel!.text = redditEntry["data"]!["author"] as? String
        
        //setting the thumbnail
        let imageString : String = redditEntry["data"]!["thumbnail"] as! String
        
        if !imageString.isEmpty {
            let imageURL: NSURL = NSURL(string: imageString)!
            let imageData: NSData = NSData(contentsOfURL: imageURL)!
            
            cell.thumbButton!.setBackgroundImage(UIImage(data: imageData)!,forState:UIControlState.Normal)
            cell.thumbButton.tag = indexPath.row
        }
        
        //get numbers of hours since the post
        let createdDateInMilliseconds: NSTimeInterval = (redditEntry["data"]!["created_utc"] as! Double)
        let createdDate = NSDate(timeIntervalSince1970: createdDateInMilliseconds)
        
        let entryDate: Int = self.hoursFrom(createdDate)
        let numberOfComments: String = String(format: "%d hours ago - %d comments", entryDate, (redditEntry["data"]!["num_comments"] as! Int))
        
        cell.numberOfCommentsLabel!.text = numberOfComments
        
        return cell
    }
    
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: NSDate(), options: []).hour
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        //checking if the image exists so we can open the view controller
        if identifier == "ShowThumbnail"{
            let thumbnailIndex = sender!.tag
            
            let redditEntry : NSMutableDictionary = self.tableData[thumbnailIndex] as! NSMutableDictionary
            selectedImageURL = redditEntry["data"]?["preview"]??["images"]??[0]["source"]??["url"] as! String
            
            if !selectedImageURL.isEmpty{
                return true
            }
        }
        
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowThumbnail"{
            let vc = segue.destinationViewController as! PostImageViewController
            vc.imageURLString = selectedImageURL
            
        }
    }
}