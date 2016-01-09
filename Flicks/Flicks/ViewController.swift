//
//  ViewController.swift
//  Flicks
//
//  Created by Gelei Chen on 8/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import UIKit


class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerClass(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "cellIdentifier"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.imageView?.image = imageAtIndex(indexPath.row)
        return cell
    }
    
    func imageAtIndex(index: Int) -> UIImage? {
        return UIImage(named: String(index))
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
}


