//
//  ViewController.swift
//  Flicks
//
//  Created by Gelei Chen on 8/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import UIKit


class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.imageView?.image = imageAtIndex(indexPath.row % 8)
        
        return cell
    }
    
    func imageAtIndex(index: Int) -> UIImage? {
        return UIImage(named: String(index))
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = ScreenSize.SCREEN_WIDTH / 2
        return CGSizeMake(width, width/2)
    }
    
}


