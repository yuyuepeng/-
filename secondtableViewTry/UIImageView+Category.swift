//
//  UIImageView+Category.swift
//  secondtableViewTry
//
//  Created by 扶摇先生 on 16/12/30.
//  Copyright © 2016年 扶摇先生. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
     public func setImage(_ imageUrl:String, placeHolder:String) -> Void {
        self.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: imageUrl)!), placeholder: UIImage.init(named: placeHolder), options: nil, progressBlock: nil, completionHandler: nil)
//        self.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: imageUrl)!), placeholder: UIImage.init(named: placeHolder), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)), KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
    }
    
}
