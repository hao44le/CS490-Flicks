//
//  ViewController.swift
//  Flicks
//
//  Created by Gelei Chen on 8/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
  
  var movieArray : NSMutableArray = []
  var pageNum:NSString = "1"
  var isHeaderRefresh = false
  
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.callServerMethod()
    self.setupCollectionRefresh()
    self.refreshData()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func callServerMethod(){
    Tool.showProgressHUD("Loading")
    ServerMethod.sharedInstance.getListOfReviews({ (array:NSMutableArray) -> Void in
      Tool.dismissHUD()
      self.movieArray = array
      self.tableView.reloadData()
      }) { (error:NSError) -> Void in
        print(error)
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
    ServerMethod.sharedInstance.getListOfReviewsByPage(self.pageNum as String, completeBlock: { (array:NSArray) -> Void in
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
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DiscoverCell
    let object = movieArray[indexPath.row] as! MovieNowPlayingCallback_result
    let url = NSURL(string: ServerConstant.getImageUrlByPath(object.poster_path))
    cell.logoImageView?.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeHolder"))
    cell.posterImageView?.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeHolder"))
    cell.titleLabel.text = object.title
    cell.descriptionLabel.text = object.overview
    return cell
  }
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
}

