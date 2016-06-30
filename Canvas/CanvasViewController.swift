//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Jessica Choi on 6/30/16.
//  Copyright © 2016 Jessica Choi. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 175
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPayTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            if trayView.center.y <= trayOriginalCenter.y{
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y / 10)
            }
            else if trayView.center.y > trayOriginalCenter.y{
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            }

            
        } else if sender.state == UIGestureRecognizerState.Ended{
            if velocity.y > 0
            {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayDown
                    }, completion: { (Bool) -> Void in
                })
            } else {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayUp
                    }, completion:  {(Bool) -> Void in
                })
            }
        }
    }

    @IBAction func didPanFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animateWithDuration(0.4, delay: 0.0, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.5, 1.5)
                }, completion: nil)
            
            /*var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
            panGestureRecognizer.delegate = self*/
            newlyCreatedFace.userInteractionEnabled = true
            //newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            var pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "didPinchNewFace:")
            pinchGestureRecognizer.delegate = self
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
        
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
        }

    }
    
    func didPinchNewFace(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        print("helLo")
        newlyCreatedFace = sender.view as! UIImageView
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.transform = CGAffineTransformScale(newlyCreatedFace.transform, scale, scale)
            sender.scale = 1
        } else if sender.state == UIGestureRecognizerState.Ended {

        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func onCustomPan(sender: UIPanGestureRecognizer){
        let translation = sender.translationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animateWithDuration(0.4, delay: 0.0, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.5, 1.5)
                }, completion: nil)
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == UIGestureRecognizerState.Ended{
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)

        }
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
