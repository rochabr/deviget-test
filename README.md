# deviget-test

Your assignment is to create a simple Reddit client that shows the top 50 entries from www.reddit.com/top .

To do this please follow this guidelines:

- Asume iOS 7 as target platform (done)
- Use UITableView / UICollectionView to arrange the data. (done)
- Please refrain from using AFNetworking, instead use NSURLSession (done)
- Support Landscape (done)
- Use Storyboards (done)

The app show be able to show data from each entry like :

- Title (at its full length, so take this into account when sizing your cells) (done)
- Author (done)
- entry date, following a format like “x hours ago” (done)
- A thumbnail for those who have a picture. (done)
- Number of comments (done)

In addition, for those having a picture (besides the thumbnail) , please allow the user to tap on the thumbnail to be sent to the full sized picture. You don’t have to implement the IMGUR API, so just opening the URL would be OK. (done)

Bonus points will be awarded for (in no particular order):

- Pagination support(done)
- Saving pictures in the picture gallery (done)
- App state preservation/restoration (done)
- Support iPhone 6/ 6+ screen size (hint: size classes) (done)