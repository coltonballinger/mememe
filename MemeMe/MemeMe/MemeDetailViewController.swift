//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Ballinger, Colton J. on 4/16/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.hidesBarsOnTap = true //hiding navigationBar when user taps the screen to view the picture
        navigationController?.tabBarController?.tabBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // setting the imageView.image equal to the selected image
        imageView?.image = meme.memedImage
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        if navigationController?.navigationBarHidden == true {
            return true
        }
        else {
            return false
        }
    }
}
