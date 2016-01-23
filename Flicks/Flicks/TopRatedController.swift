//
//  TopRatedController.swift
//  Flicks
//
//  Created by Gelei Chen on 22/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import UIKit

class TopRatedController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    
    var movieArray : NSMutableArray = []
    var filteredMovies = []
    var pageNum:NSString = "1"
    var isHeaderRefresh = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor = Utils.mainColor
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        
        self.tabBarController!.hidesBottomBarWhenPushed = true
        self.callServerMethod()
        self.setupCollectionRefresh()
        self.refreshData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func callServerMethod(){
        Tool.showProgressHUD("Loading")
        ServerMethod.sharedInstance.getTopRated({ (array:NSMutableArray) -> Void in
            Tool.dismissHUD()
            self.movieArray = array
            self.tableView.reloadData()
            }) { (error:NSError) -> Void in
                Tool.showErrorHUD("There is an network error")
        }
    }
    func setupCollectionRefresh(){
        let header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.isHeaderRefresh = true
            self.pageNum = "1"
            self.refreshData()
        })
        header.setTitle("Pull down to refresh", forState: MJRefreshState.Idle)
        header.setTitle("Release to refresh", forState: MJRefreshState.Pulling)
        header.setTitle("Loading ...", forState: MJRefreshState.Refreshing)
        header.stateLabel?.textColor = UIColor.whiteColor()
        header.lastUpdatedTimeLabel?.hidden = true
        self.tableView.mj_header = header
        
        self.tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: { () -> Void in
            let num = self.pageNum.integerValue + 1
            self.pageNum = String(num)
            self.refreshData()
        })
    }
    
    func refreshData(){
        Tool.showProgressHUD("Loading more moviews")
        ServerMethod.sharedInstance.getTopRatedByPage(self.pageNum as String, completeBlock: { (array:NSArray) -> Void in
            Tool.dismissHUD()
            if self.tableView.mj_header.isRefreshing(){
                self.tableView.mj_header.endRefreshing()
            }
            if self.tableView.mj_footer.isRefreshing(){
                self.tableView.mj_footer.endRefreshing()
            }
            if self.isHeaderRefresh{
                self.movieArray.removeAllObjects()
                self.isHeaderRefresh = false
            }
            for item in array{
                self.movieArray.addObject(item)
            }
            if 20 < array.count{
                self.tableView.mj_footer.removeFromSuperview()
            }else{
                self.setupCollectionRefresh()
            }
            self.tableView.reloadData()
            
            }) { (erro:NSError) -> Void in
                
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translationInView(scrollView).y < 0{
            changeTabBar(true, animated: true)
        }
        else{
            changeTabBar(false, animated: true)
        }
    }
    func changeTabBar(hidden:Bool, animated: Bool){
        let tabBar = self.tabBarController!.tabBar
        if tabBar.hidden == hidden{ return }
        let frame = tabBar.frame
        let offset = (hidden ? (frame.size.height) : -(frame.size.height))
        let duration:NSTimeInterval = (animated ? 0.5 : 0.0)
        tabBar.hidden = false
        
        UIView.animateWithDuration(duration,
            animations: {tabBar.frame = CGRectOffset(frame, 0, offset)},
            completion: {
                if $0 {tabBar.hidden = hidden}
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredMovies.count != 0 {
            return filteredMovies.count
        } else {
            return movieArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DiscoverCell
        var object : MovieNowPlayingCallback_result!
        if filteredMovies.count != 0 {
            object = filteredMovies[indexPath.row] as! MovieNowPlayingCallback_result
        } else {
            object = movieArray[indexPath.row] as! MovieNowPlayingCallback_result
        }
        
        let url = NSURL(string: ServerConstant.getImageUrlByPath(object.poster_path))
        cell.logoImageView?.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeHolder"))
        cell.posterImageView?.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeHolder"))
        cell.titleLabel.text = object.title
        cell.descriptionLabel.text = object.overview
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movieArray
        } else {
            let searchPredicate = NSPredicate(format: "title CONTAINS[c] %@", searchText)
            let filteredArray = movieArray.filteredArrayUsingPredicate(searchPredicate)
            if filteredArray.count != 0 {
                filteredMovies = filteredArray
            }
        }
        tableView.reloadData()
    }
}



