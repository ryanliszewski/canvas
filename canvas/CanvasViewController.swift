//
//  CanvasViewController.swift
//  canvas
//
//  Created by Ryan Liszewski on 3/15/17.
//  Copyright © 2017 Smiley. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayCenterWhenOpen = trayView.center
        trayCenterWhenClosed = CGPoint(x: trayView.center.x , y: trayView.center.y + 200)
        
        trayView.center = trayCenterWhenClosed
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onFacePanGesture(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let imageView = sender.view as! UIImageView
        
        
        if(sender.state == UIGestureRecognizerState.began){
             self.newlyCreatedFace = UIImageView(image: imageView.image)
             self.view.addSubview(self.newlyCreatedFace)
            
            self.newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceCenter = newlyCreatedFace.center
        } else if (sender.state == UIGestureRecognizerState.changed){
            self.newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceCenter.x, y: newlyCreatedFaceCenter.y + translation.y)
        }
    }
    
    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.trayView)
        
        
        if(sender.state == UIGestureRecognizerState.began){
        
            trayOriginalCenter = trayView.center
            print("Gesture began at: %@", NSStringFromCGPoint(location))
        } else if (sender.state == UIGestureRecognizerState.changed){
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + sender.translation(in: self.trayView).y)
            
            print("Gesture changed at: %@", NSStringFromCGPoint(location))
        } else if (sender.state == UIGestureRecognizerState.ended){
            print("Gesture ended at: %@", NSStringFromCGPoint(location))
            
            if(sender.velocity(in: self.trayView).y > 0){
                UIView.animate(withDuration: 0.3 , animations: {
                    self.trayView.center = self.trayCenterWhenClosed
                })
            
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.trayView.center = self.trayCenterWhenOpen
                })
            }
        }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
