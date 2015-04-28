//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Ballinger, Colton J. on 4/16/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var memes: [Meme]!
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        navigationController?.tabBarController?.tabBar.hidden = false
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count // the number of items in the collection will be equal to the number of items in the memes array
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        var meme = memes[indexPath.row]
        
        cell.imageView?.image = meme.memedImage // the images will be whatever images have been added to the memes array
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        meme = memes[indexPath.row] // passes the meme objects
        
        performSegueWithIdentifier("collectionViewSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let MemeDetailVC = segue.destinationViewController as! MemeDetailViewController
        
        MemeDetailVC.meme = self.meme
    }
}
