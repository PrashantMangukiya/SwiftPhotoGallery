//
//  PhotoCollectionViewCell.swift
//  SwiftPhotoGallery
//
//  Created by Prashant on 12/09/15.
//  Copyright (c) 2015 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    // gallery image
    @IBOutlet var galleryImage: UIImageView!

    
    // set image corner radious and border
    func setPhotoCornerRadious(radious radious: Int){
        self.galleryImage.layer.cornerRadius = CGFloat(radious)
        self.galleryImage.layer.borderWidth = 1
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
    
}
