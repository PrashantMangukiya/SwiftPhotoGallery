//
//  PhotoGalleryViewController.swift
//  SwiftPhotoGallery
//
//  Created by Prashant on 12/09/15.
//  Copyright (c) 2015 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit


class PhotoGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // collection view cell default width, height
    var cellWidth: Int = 100
    var cellHeight: Int = 100
    
    
    // outlet - collection view for photo listing
    @IBOutlet var photoCollectionView: UICollectionView!
    
    // outlet - activity indicator (spinner)
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    // refresh button to reload data from server.
    @IBAction func refreshButtonAction(sender: UIBarButtonItem) {
        // photo gallery data
        self.loadPhotoGallery()
    }
    
    
    // photo list (data loaded from remote json file into this variable)
    var photoList : [Photo] = [Photo]()
    
    
    
    
    // MARK: - view function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        // stop the spinner
        self.spinner.stopAnimating()
        
        // set collectionview delegate and datasource
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Calculate cell width, height based on screen width
        self.calculateCellWidthHeight()
     
        // if photo list empty then try to load data
        if self.photoList.isEmpty {
            self.loadPhotoGallery()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Collection view dataSource
    
    // number of section in collection view
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // number of photos in collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    // return width and height of cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: self.cellWidth, height: self.cellHeight)
    }
    
    // configure cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        // get collection view reusable  cell
        let newCell = collectionView.dequeueReusableCellWithReuseIdentifier("CellPhoto", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        // set corner radious for image
        newCell.setPhotoCornerRadious(radious: self.cellWidth/4)
        
        // get current photo object from list
        let photo = self.photoList[indexPath.row]
        
        // set placeholder until image downloaded from server.
        newCell.galleryImage.image = UIImage(named: "placeholder")
        
        // Download photo asynchronously
        let imagePath = REMOTE_DATA_FOLDER_PATH + photo.thumbImage
        
        // if image path convertible to url then load image asynchronously and set within cell
        if let imageURL = NSURL(string: imagePath) {
            self.downloadCellPhotoInBackground(imageUrl: imageURL, photoCell: newCell)
        }
        
        // return cell
        return  newCell
    }
    
    
    
    
    // MARK: - Collection view delegate
    
    // go to single photo list when clicked on any photo
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {         
        self.performSegueWithIdentifier("segueSinglePhoto", sender: self)
    }
    
    
    
    
    // MARK: - Utility function
    
    // load gallery json file data from remove server and parse it to array
    // then reload collection view for display photo gallery
    private func loadPhotoGallery() -> Void {
        
        // make existing photo list empty if any data
        self.photoList.removeAll(keepCapacity: false)
        
        // reload collection view so content become clear
        self.photoCollectionView.reloadData()
        
        // start the spinner
        self.spinner.startAnimating()
        
        // create path for photo gallery json file
        let galleryJsonFilePath : String = REMOTE_DATA_FOLDER_PATH + "gallery.json"
        
        //  fetch json data
        self.fetchJsonData(
            jsonFilePath: galleryJsonFilePath,
            onCompletion: { (jsonData: JSON) -> Void in
                            
                // fetch Photo object
                let photosJSON = jsonData["Photos"]
                for (_, subJson): (String, JSON) in photosJSON {
                    
                    // creare photo object
                    let newPhoto = Photo()
                    newPhoto.title = subJson["title"].string!
                    newPhoto.thumbImage = subJson["thumbImage"].string!
                    newPhoto.largeImage = subJson["largeImage"].string!
                    
                    // append photo to list
                    self.photoList.append(newPhoto)
                }
                
                // stop spinner and refresh collection view
                // important - gui operation must be within main queue
                dispatch_async( dispatch_get_main_queue(), {
                    self.spinner.stopAnimating()
                    self.photoCollectionView.reloadData()
                })
            
            },
            onError: { () -> Void in
                // important - gui operation must be within main queue
                dispatch_async(dispatch_get_main_queue(), {

                    // stop the spinner
                    self.spinner.stopAnimating()
                    
                    // show error message
                    self.showAlertMessage(alertTitle: "Error", alertMessage: "Data fetching error. \n" + galleryJsonFilePath)
                })
            }
        )
    }
    
    // download Image asynchronously and assign to collection view cell
    func downloadCellPhotoInBackground( imageUrl imageUrl: NSURL, photoCell: PhotoCollectionViewCell ) {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(imageUrl, completionHandler:
            { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                
                // if no error then update photo
                if (error == nil) {
                    // update cell photo (GUI must updated in main_queue)
                    dispatch_async( dispatch_get_main_queue(), {
                        let imageData = NSData(data: data!)
                        photoCell.galleryImage.image = UIImage(data: imageData )
                        photoCell.galleryImage.contentMode = UIViewContentMode.ScaleAspectFill
                    })
                }
            }
        )
        
        // resume - important
        task.resume()
    }
    
    // calculate collection view cell width and height based on screen width
    private func calculateCellWidthHeight() {
        
        // how many photos display in one row
        let numberOfPhotoInRow : CGFloat = 3
        
        // find current screen width
        let screenWidth = self.photoCollectionView.frame.width
        
        // deduct spacing from screen width
        // Formula: screeWidth - leftSpace - ( spaceBetweenThumb * (numberOfPhotoInRow - 1) ) - rightSpace
        let netWidth = screenWidth - 5 - ( 5 * (numberOfPhotoInRow - 1) ) - 5
        
        // calcualte single thumb width
        let thumbWidth = Int( netWidth / numberOfPhotoInRow)
        
        // assign width to class variable
        self.cellWidth = thumbWidth
        self.cellHeight = thumbWidth
    }
    
    // fetch json file content from a given path and convert it to JSON object
    // json object conversion done using swifyJSON library
    // this function can be used to fetch any json file stored at remote url
    private func fetchJsonData(jsonFilePath jsonFilePath: String, onCompletion: (jsonData: JSON) -> Void, onError: () -> Void ) {
        
        // convert file path to url
        if let jsonFileUrl = NSURL(string: jsonFilePath) {
            
            // create url request
            let urlRequest : NSURLRequest = NSMutableURLRequest(URL: jsonFileUrl)
            
            // create url session
            let sharedSession : NSURLSession = NSURLSession.sharedSession()
            
            // request data task
            let dataTask = sharedSession.dataTaskWithRequest(urlRequest,
                completionHandler:
                {
                    (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    
                    if let httpResponse = response as? NSHTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            // convert data to JSON object
                            let receivedJSON : JSON = JSON(data: data!)
                            
                            // call the completion block
                            onCompletion(jsonData: receivedJSON)
                        }else{
                            // call error block
                            onError()
                        }
                    }else{
                        // call error block
                        onError()
                    }
                }
            )
            
            dataTask.resume() // important
            
        } else {
            // call error block
            onError()
        }
    }
    
    // show alert with ok button
    private func showAlertMessage(alertTitle alertTitle: String, alertMessage: String ) -> Void {
        
        // create alert controller
        let alertCtrl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert) as UIAlertController
        
        // create action
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
            { (action: UIAlertAction) -> Void in
                // you can add code here if needed
        })
        
        // add ok action
        alertCtrl.addAction(okAction)
        
        // present alert
        self.presentViewController(alertCtrl, animated: true, completion: { (void) -> Void in
            // you can add code here if needed
        })
    }
    
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "segueSinglePhoto" {
            
            // find selected photo index path
            let clickedIndexPath : [NSIndexPath] = self.photoCollectionView!.indexPathsForSelectedItems()!
            
            // create destination view controller
            let destViewCtrl = segue.destinationViewController as! SinglePhotoViewController

            // set clicked photo index path for new page contoller
            destViewCtrl.clickedPhotoIndexPath = clickedIndexPath[0]
            
            // set current screne photo list to new controller
            destViewCtrl.photoList = self.photoList
        }
        
    }
    

}
