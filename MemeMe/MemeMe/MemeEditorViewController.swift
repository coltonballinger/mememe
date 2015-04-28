//
//  ViewController.swift
//  MemeMe
//
//  Created by Ballinger, Colton J. on 4/13/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    // var memes: [Meme]!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -2]

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        hideShareButton()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera) // only allowing the camera button to be accessible if device has capability
        
        subscribeToShowNotification()
        subscribeToHideNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeToShowNotification()
        unsubscribeToHideNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .Camera //whenever the camera button is clicked, this tells the imagePicker to use the built in camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBAction func pickPhoto(sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .PhotoLibrary //same as above, but tells the imagePicker to use the photo album on the phone
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBAction func sharePhoto(sender: UIBarButtonItem) {
        
        var memedImage = generatedMemeImage() //setting memedImage to generatedMemeImage(), so that we can use it below as an array of generatedMemeImage objects
        
        var activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil) //setting up activity view controller to share memes
        
        // allowing me to customize what happens after completiion
        activityVC.completionWithItemsHandler = {
            
            (string: String!, completed: Bool, object: [AnyObject]!, error: NSError!) -> Void in
            
            // if there is no if statement, the app will throw an exception when you try to navigate to the tabController. Must be completed before saving and going VC
            if completed == true {
                
                self.save()
                self.goToTabController()
            }
        }
        
        presentViewController(activityVC, animated: true, completion: nil)
    }
    @IBAction func cancel(sender: AnyObject) {
        
        goToTabController()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image // setting the imageView.image equal to the image variable we declared above
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func save() {
        
        var meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, image: imageView.image!, memedImage: generatedMemeImage())
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    func generatedMemeImage() -> UIImage {
        
        hideToolBars(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size) //create a new image context same size as the view
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true) //renders the image
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() //setting the image context to a UIImage
        UIGraphicsEndImageContext()
        
        hideToolBars(false)
        
        return memedImage
    }
    
    func hideShareButton() {
        if imageView.image == nil {
            shareButton.enabled = false // dont want to share an image unless an image has been picked
        }
        else {
            shareButton.enabled = true
            view.backgroundColor = UIColor.blackColor()
        }
    }
    
    func hideToolBars(action: Bool) {
        
        navigationController?.navigationBarHidden = action
        toolbar.hidden = action
    }
    
    func goToTabController() {
        
        var tabVC = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarViewController") as! UITabBarController
        
        self.presentViewController(tabVC, animated: true, completion: nil)
    }
}

