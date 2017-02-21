//
//  secondCell.swift
//  secondtableViewTry
//
//  Created by 扶摇先生 on 16/12/9.
//  Copyright © 2016年 扶摇先生. All rights reserved.
//

import UIKit
import Kingfisher
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class secondCell: UITableViewCell {
    var model1 : scrollModel!
    
    var model : scrollModel {
        set{
        
            self.model1 = newValue
            self.nameLabel.text = self.model1.title
            self.backImage.setImage(self.model1.pic, placeHolder: "banner_placeHolder")
           
        }
        get{
            return self.model1
        }
    }
    
    //懒加载创建标题label
    lazy var nameLabel: UILabel = {
        var singleLength = screenWidth/640.0
        var nameLabel = UILabel.init(frame: CGRect.init(x: 100 * singleLength, y: 300 * singleLength, width: 440 * singleLength, height: 80 * singleLength))
        nameLabel.font = UIFont.systemFont(ofSize: 19)
        nameLabel.textAlignment = NSTextAlignment.center;
        nameLabel.textColor = UIColor.white
        return nameLabel
    }()
    //    懒加载创建背景图
    lazy var backImage:UIImageView = {
        var singleLength = screenWidth/640.0
        var backImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400 * singleLength))
        return backImage
    } ()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubViews()
    }
    fileprivate func createSubViews() {
        addSubview(self.backImage)
        self.backImage.addSubview(nameLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
