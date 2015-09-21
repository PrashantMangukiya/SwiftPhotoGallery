# Swift Photo Gallery
Photo gallery demo application build using Swift 2, Xcode 7, and iOS 9.

## Overview
Swift based photo gallery demo application that will fetch ``json`` data from remote server and parse it using ``SwiftyJSON`` libray. Once parsing done, it will load thumb images ``asynchronously`` from remote location. Whenever user click thumb image it will also fetch large image ``asynchronously`` from remote location. You can use this application as a base for any ``Photo Gallery`` project and expand it. You can use it free for either personal or commercial use. 

**It consist functionality below:**
+ Fetch ``json`` data file ``asynchronously``.
+ Parsing json data using ``SwiftyJSON`` library.
+ Fetch thumb image ``asynchronously``.
+ When clicked thumb, it will fetch large image ``anynchronously``.
+ User can scroll to see large image one by one.

![ScreenShot iPhone4](../master/Screenshots/main-1t.png)
![ScreenShot iPhone4](../master/Screenshots/main-2t.png)

## Platform
+ Swift 2
+ Xcode 7
+ iOS 9
+ SwiftyJSON (for json data parsing)

## Supported Device
iPhone 4s, 5, 5s, 5c, 6, 6 Plus, 6s, 6s Plus, all iPad having iOS 8.4, iOS 9

## Technology used
+ Colletion view controller ``UICollectionView``.
+ Collection view Custom cell  ``UICollectionViewCell``.
+ ``SwiftyJSON`` library for json data parsing.
+ Loading json file asynchrnously using ``NSURLSession``.
+ Loading image file asynchrnously using ``NSURLSession``.
+ Simple and Clean interface.
+ Build with Xcode storyboard.
+ Adaptive layout for major screen size support.
+ Created with ``Swift 2``, ``Xcode 7``, ``iOS 9``, and ``SwifyJSON``.

## How To Use

### Setup Data folder
+ Upload ``SwiftPhotoGallery-Data`` folder on your server.
+ Open ``Common.swift`` and set value for ``REMOTE_DATA_FOLDER_PATH`` that point to data folder.
e.g.
<pre>
// Remote data folder path
var REMOTE_DATA_FOLDER_PATH = "http://www.YourWebsite.com/SwiftPhotoGallery-Data/"
</pre>

### Setup Gallery content.
+ Open ``gallery.json`` from ``SwiftPhotoGallery-Data`` folder.
+ Add/update json data within ``gallery.json`` file as needed.
+ Put thumb and large image accordingly within ``SwiftPhotoGallery-Data`` folder.


## Screenshots

**iPhone 4s**

![ScreenShot iPhone4](../master/Screenshots/main-1t.png)
![ScreenShot iPhone4](../master/Screenshots/main-2t.png)

**iPad**

![ScreenShot iPhone4](../master/Screenshots/iPad-1.png)

![ScreenShot iPhone4](../master/Screenshots/ipad-2.png)

## License
SwiftPhotoGallery is available under the MIT license. See the LICENSE file for more info.

## Image Source
Sample images used for gallery data are taken from pixabay for demo purpose only. I does not claim ownership over that images.

## Legacy Version
Xcode 6, iOS 8.4 based source code moved to ``Source-Xcode6`` folder. Please note that Xcode 6 based source code are deprecated and not upto date. I will suggest to use latest Xcode 7 based source from``SwiftPhotoGallery`` folder at root.


