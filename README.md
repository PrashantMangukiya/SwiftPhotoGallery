# Swift Photo Gallery
Photo gallery demo application build using Swift, Xcode, and iOS

## Overview
Swift based photo gallery that load ``json`` file from remote server and parse it using ``SwiftyJSON`` libray. Once parsing done, it load thumb images ``asynchronously`` from remote location. When user click thumb image it fetch large image too  ``asynchronously`` from remote location. This is full application you can use as a base for any ``Photo Gallery`` project and expand it. You can use it free for either personal or commercial use. 

**It consist functionality below:**
+ Fetch ``json`` data file ``asynchronously``.
+ Parsing json data using ``SwiftyJSON`` library.
+ Fetch thumb image ``asynchronously``.
+ When clicked thumb, it will fetch large image ``anynchronously``.
+ User can scroll to see large image one by one.

![ScreenShot iPhone4](../master/Screenshots/main-1t.png)
![ScreenShot iPhone4](../master/Screenshots/main-2t.png)

## Platform
+ Swift 1.2
+ iOS 8
+ Xcode 6.4
+ SwiftyJSON

## Supported Device
iPhone 4s, 5, 5s, 5c, 6, 6 Plus, iPad having iOS 8.

## Technology used
+ Colletion view controller ``UICollectionView``.
+ Collection view Custom cell  ``UICollectionViewCell``.
+ ``SwiftyJSON`` library for json data parsing.
+ Loading json file asynchrnously using ``NSURLSession``.
+ Loading image file asynchrnously using ``NSURLSession``.
+ Simple and Clean interface.
+ Build with Xcode storyboard.
+ Adaptive layout for major screen size support.
+ Created with ``Swift 1.2``, ``iOS 8``, ``Xcode 6.4`` and ``SwifyJSON``.

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

