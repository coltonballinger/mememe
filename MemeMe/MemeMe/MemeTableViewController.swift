//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Ballinger, Colton J. on 4/16/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    var memes: [Meme]!
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: ("presentEditorViewController"))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        navigationController?.tabBarController?.tabBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell") as! MemeTableViewCell
        
        var meme = memes[indexPath.row]
        var memeText = meme.topText + " " + meme.bottomText
        
        // setting cells equal to whatever the memeImage and memeText are set to in the memes array
        cell.memeImageView.image = meme.memedImage 
        cell.memeNameLabel.text = memeText
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        meme = memes[indexPath.row]
        performSegueWithIdentifier("memeSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // setting up swipe to delete
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Preparing to transtion to MemeDetailViewController
        if segue.identifier == "memeSegue" {
            let detailVC = segue.destinationViewController as! MemeDetailViewController
            detailVC.meme = self.meme
        }
    }
    
    func presentEditorViewController() {
        // presenting the MemeEditorViewController when the add button is clicked
        var memeEditor = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorVC") as! MemeEditorViewController
        let navController = UINavigationController(rootViewController: memeEditor)
        self.presentViewController(navController, animated: true, completion: nil)
    }
}
