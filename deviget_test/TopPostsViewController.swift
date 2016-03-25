//
//  TopPostsViewController.swift
//  deviget_test
//
//  Created by Fernando Rocha Silva on 3/23/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import UIKit

class TopPostsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var isPageRefreshing = false
    var pageCount = 0
    
    var lastPageId = ""
    var selectedImageURL = ""
    
    var tableData = []
    
    var thumbnailArray = NSMutableArray()
    var results = NSMutableArray()
    
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
                
                //setting last page id, for pagination
                self.lastPageId = theJSON["data"]!!["after"] as! String
                
                let currentResults : NSArray = theJSON["data"]!!["children"] as! NSArray
                self.results.addObjectsFromArray(currentResults as [AnyObject])
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableData = self.results
                    self.populateImageArray(self.results)
                    self.redditListTableView!.reloadData()
                    
                    self.isPageRefreshing = false
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
        cell.thumbButton!.setBackgroundImage(thumbnailArray.objectAtIndex(indexPath.row) as? UIImage,forState:UIControlState.Normal)
        cell.thumbButton.tag = indexPath.row
        
        //get numbers of hours since the post
        let createdDateInMilliseconds: NSTimeInterval = (redditEntry["data"]!["created_utc"] as! Double)
        let createdDate = NSDate(timeIntervalSince1970: createdDateInMilliseconds)
        
        let entryDate: Int = self.hoursFrom(createdDate)
        let numberOfComments: String = String(format: "%d hours ago - %d comments", entryDate, (redditEntry["data"]!["num_comments"] as! Int))
        
        cell.numberOfCommentsLabel!.text = numberOfComments
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row + 1 == tableData.count{
            if isPageRefreshing == false {
                isPageRefreshing = true;
                pageCount += 25
                getRedditJSON("https://www.reddit.com/r/all/top.json?count=\(pageCount)&after=\(lastPageId)")
            }
        }
    }
    
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: NSDate(), options: []).hour
    }
    
    //function to prepopulate an array with thumbnails, making the request quicker and handling possible reusable cell issues
    func populateImageArray(array: NSArray) {
        var i = 0
        for entry in array{
            let redditEntry : NSMutableDictionary = entry as! NSMutableDictionary
            
            //setting the thumbnail
            let imageString : String = redditEntry["data"]!["thumbnail"] as! String
            if !imageString.isEmpty{
                do {
                    let imageURL: NSURL = NSURL(string: imageString)!
                    let imageData: NSData = try NSData(contentsOfURL: imageURL, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    thumbnailArray.insertObject(UIImage(data: imageData)!, atIndex: i)
                }catch {
                    thumbnailArray.insertObject(UIImage(named: "No_Image")!, atIndex: i)
                }
            }else{
                thumbnailArray.insertObject(UIImage(named: "No_Image")!, atIndex: i)
            }

            i += 1
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        //checking if the image exists so we can open the view controller
        if identifier == "ShowThumbnail"{
            let thumbnailIndex = sender!.tag
            
            //checking if the post contains images
            let redditEntry : NSMutableDictionary = self.tableData[thumbnailIndex] as! NSMutableDictionary
            if redditEntry["data"]?["preview"]??["images"]??[0]["source"]??["url"] != nil{
                selectedImageURL = redditEntry["data"]?["preview"]??["images"]??[0]["source"]??["url"] as! String
                if !selectedImageURL.isEmpty{
                    return true
                }
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