//
//  DetailViewController.swift
//  Flicks
//
//  Created by Gelei Chen on 22/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    

    var backgroundImage: UIImageView!
    var movieDetails : MovieNowPlayingCallback_result!
    
    

    func setTabBarVisible(visible:Bool, animated:Bool) {
        
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
                return
            }
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setTabBarVisible(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
        addScrollView()
    }
    func configureBackground(){
        let url = NSURL(string: ServerConstant.getImageUrlByPath(self.movieDetails.poster_path))
        self.backgroundImage = UIImageView(frame: CGRectMake(0, 64, ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT - 64))
        self.backgroundImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeHolder"))
        self.view.addSubview(self.backgroundImage)
        
        self.title = self.movieDetails.title
    }
    func addScrollView(){
        
        
        
        let scroll = UIScrollView(frame: CGRectMake(0,ScreenSize.SCREEN_HEIGHT * 0.7,ScreenSize.SCREEN_WIDTH,ScreenSize.SCREEN_HEIGHT))
        scroll.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        scroll.layer.shadowColor = UIColor.blackColor().CGColor
        scroll.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        
        let release_dateLabel = UILabel(frame: CGRectMake(10,0,ScreenSize.SCREEN_WIDTH - 10,20))
        release_dateLabel.text = "Realease Date: " + self.movieDetails.release_date
        release_dateLabel.textColor = UIColor.whiteColor()
//        release_dateLabel.textAlignment = NSTextAlignment.Center
        scroll.addSubview(release_dateLabel)
        
        let original_titleLabel = UILabel(frame: CGRectMake(10,20,ScreenSize.SCREEN_WIDTH - 10,20))
        original_titleLabel.text = "Original Title: " + self.movieDetails.original_title
        original_titleLabel.textColor = UIColor.whiteColor()
//        original_titleLabel.textAlignment = NSTextAlignment.Center
        scroll.addSubview(original_titleLabel)
        
        let overview_titleLabel = UILabel(frame: CGRectMake(10,40,ScreenSize.SCREEN_WIDTH - 10,100))
        overview_titleLabel.text = "overview Title: " + self.movieDetails.overview
        overview_titleLabel.textColor = UIColor.whiteColor()
//        overview_titleLabel.textAlignment = NSTextAlignment.Center
        overview_titleLabel.numberOfLines = 0
        scroll.addSubview(overview_titleLabel)
        
        
        
        
        
        self.view.addSubview(scroll)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setTabBarVisible(true, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
