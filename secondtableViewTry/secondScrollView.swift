//
//  secondScrollView.swift
//  secondtableViewTry
//
//  Created by 扶摇先生 on 16/12/29.
//  Copyright © 2016年 扶摇先生. All rights reserved.
//

import UIKit
import Kingfisher

protocol secondScrollViewDelegate {
    func 点击事件(_ modelIndex:Int) -> Void

}
class secondScrollView: UIView ,UIScrollViewDelegate{
    var page = UIPageControl()
    var delegate: secondScrollViewDelegate?
    var imageCount : Int = 0
    var singleLength = screenWidth/640.0
    var timer = Timer()
    
    lazy var scrollView:UIScrollView = {
        var singleLength = screenWidth/640.0
        var scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 300 * singleLength))
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    init(frame: CGRect, models: [scrollModel]) {
        super.init(frame: frame)
        imageCount = models.count
        self.scrollView.isUserInteractionEnabled = true
        self.createImageViews(models)
        self.addSubview(self.scrollView)
        self.addTimer()
        self.createPageControll()
    }
    func addTimer() -> Void {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true, block: { (timer) in
            var index = self.page.currentPage
            if index == self.imageCount + 1 {
                index = 0
            }else {
                index += 1
            }
            NSLog("index = %ld",index);
            self.scrollView.setContentOffset(CGPoint.init(x: CGFloat(index + 1) * screenWidth, y: 0), animated: true)
        })
    }
    func createPageControll() -> Void {
        self.page = UIPageControl(frame: CGRect(x: 0, y: CGFloat( 270) * singleLength, width: screenWidth, height: CGFloat(30) * singleLength))
        self.page.currentPage = 0
        self.page.numberOfPages = imageCount
        page.addTarget(self, action: #selector(onClick(_:)), for: UIControlEvents.touchUpInside)
        self.page.backgroundColor = UIColor.black
        self.page.alpha = 0.3
        self.addSubview(page)
    }
    func onClick(_ page:UIPageControl) -> Void {
        self.scrollView .setContentOffset(CGPoint.init(x: CGFloat(page.currentPage) * screenWidth, y: 0), animated: true)
        
    }
    func createImageViews(_ models:[scrollModel]) -> Void {
        var i :Int = 0
//        let tap = UITapGestureRecognizer.init(target: self, action: "onTap:")
       

        
//        var singleLength = screenWidth/640.0
        self.scrollView.contentSize = CGSize.init(width: screenWidth * CGFloat(models.count) + 2, height: 300 * singleLength)
        for model:scrollModel in models {
            let imageView = UIImageView.init(frame: CGRect.init(x: screenWidth * CGFloat(i) + screenWidth, y: 0, width: screenWidth, height: 300 * singleLength))
             let tap = UITapGestureRecognizer.init(target: self, action: #selector(onTap(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.setImage(model.pic, placeHolder: "banner_placeHolder")
            self.scrollView .addSubview(imageView)
            imageView.addGestureRecognizer(tap)
            imageView.tag = i
            i += 1
        }
        self.scrollView.setContentOffset(CGPoint.init(x: screenWidth, y: 0), animated: false)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onTap(_:)))
        
        var firstImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 300 * singleLength))
        firstImage.tag = 1001
        firstImage.setImage(models[models.count - 1].pic, placeHolder: "banner_placeHolder")
        firstImage.addGestureRecognizer(tap)
        self.scrollView.addSubview(firstImage)
        var lastImage = UIImageView.init(frame: CGRect.init(x:CGFloat(models.count + 1) * screenWidth, y: 0, width: screenWidth, height: 300 * singleLength))
        lastImage.tag = 2001
        lastImage.setImage(models[0].pic, placeHolder: "banner_placeHolder")
        lastImage.addGestureRecognizer(tap)
        self.scrollView.addSubview(lastImage)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var num = Int((self.scrollView.contentOffset.x + 1)/screenWidth)
        if num == imageCount + 1 {
            num = 1
        }else if num == 0 {
            num = imageCount
        }
        self.page.currentPage = num - 1
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        let width = screenWidth
        let numb = Int((self.scrollView.contentOffset.x + width * 0.5) / width)
        
        if numb == imageCount + 1 {
            self.scrollView.setContentOffset(CGPoint.init(x: width, y: 0), animated: false)
        } else if (numb == 0) {
            self.scrollView.setContentOffset(CGPoint.init(x: width * CGFloat( imageCount), y: 0), animated: false)
        }

    }
    func onTap(_ tap:UITapGestureRecognizer) -> Void {
        
        
        if tap.view?.tag == 1001 {
            self.delegate?.点击事件(imageCount - 1)
            
        } else if tap.view?.tag == 2001{
            self.delegate?.点击事件(0)
        }else {
            self.delegate?.点击事件((tap.view?.tag)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
