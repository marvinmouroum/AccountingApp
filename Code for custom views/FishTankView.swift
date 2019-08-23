//
//  FishTankView.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 29.12.17.
//  Copyright © 2017 LCR. All rights reserved.
//

import UIKit

/// A view that spawns fish to swim around randomly in the view
class FishTankView: UIView {
    

    //fish in the tank
    private var fish:[Fish] = []
    private var filteredFish:[Fish] = []
    private var swimming:Bool = true
    
    private var message_for_empty_tank:String = ""
    private lazy var label_for_empty_tank:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Design.defaultFont, size: Design.smallFontSize)
        label.textAlignment = .center
        label.textColor = .white
        label.text = self.message_for_empty_tank
        return label
    }()
    public func set_message_for_empty_tank(_ message:String?){
        if message == nil { label_for_empty_tank.removeFromSuperview();return }
        label_for_empty_tank.text = message
        place_layber_for_empty_tank()
    }
    
    private func place_layber_for_empty_tank(){
        self.addSubview(label_for_empty_tank)
        label_for_empty_tank.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label_for_empty_tank.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label_for_empty_tank.heightAnchor.constraint(equalToConstant: Design.smallFontSize).isActive = true
        label_for_empty_tank.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    public func getFish(fish:Int)->Fish?{
        if self.fish.count <= fish { return nil }
        return self.fish[fish]
    }
    
    public func addFish(fish:UIView, tag:String){
        self.fish.append(spawnFish(body: fish, path: movementCurve,tag:tag))
    }
    public func addFish(fish:[UIView],tags:[String]){
        for f in fish {
            self.fish.append(spawnFish(body: f, path: movementCurve, tag: tags[fish.index(of: f)!]))
        }
    }
    public func removeFish(fish:Int){ self.fish.remove(at: fish) }
    public func removeFish(fishTag:String){
        if let index = (self.fish.index { (f) -> Bool in
            return f.tag == fishTag
        })
        { self.fish.remove(at: index) }
    }
    public func clearTank(){ self.fish.removeAll() }
    
    private var movementCurve:UIBezierPath {
        get {
            let size = CGSize( width: self.frame.width*0.8,
                               height: self.frame.height*0.8)
            
            return BezierCircle(frame: size) }
    }
    
    private func spawnFish(body:UIView, path: UIBezierPath,tag:String)->Fish{
        var color:UIColor = Design.lightBlue
        if body.backgroundColor != nil { color = body.backgroundColor! }
        let fish = Fish(body: body, path: path, color: color, tag:tag)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pannedFish))
        fish.body.addGestureRecognizer(pan)
        return fish
    }
    
    private var constant:CGFloat = 50 //constant for insets
    public func placeBetween(top:UIView?, right:UIView?, bottom:UIView?, left:UIView?){
        guard let supView = self.superview  else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topView = top {
            self.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: constant).isActive = true
        }else {
            self.topAnchor.constraint(equalTo: supView.topAnchor, constant: constant).isActive = true
        }
        
        if let rightView = right {
            self.trailingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: -constant).isActive = true
        }else {
            self.trailingAnchor.constraint(equalTo: supView.trailingAnchor, constant: -constant).isActive = true
        }
        
        if let bottomView = bottom {
            self.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -constant).isActive = true
        }else {
            self.bottomAnchor.constraint(equalTo: supView.bottomAnchor, constant: -constant).isActive = true
        }
        
        if let leftView = left {
            self.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: constant).isActive = true
        }else {
            self.leadingAnchor.constraint(equalTo: supView.leadingAnchor, constant: constant).isActive = true
        }
    }
    
    private func show_fish(_ animate:Bool){
        
        swimming = animate
        
        for view in self.subviews { view.removeFromSuperview() }
        
        for f in self.fish {
            if !filteredFish.contains(where: { (fish) -> Bool in
                return fish.tag == f.tag
            }){
                f.body.frame.origin = (f.path as! BezierCircle).startPoint!
                let subviews:UInt32 = UInt32(self.subviews.count)
                self.insertSubview(f.body, at: Int(arc4random_uniform(subviews)))
                self.addSubview(f.body)
                
                //adding or remobing the animation
                if animate{
                    add_animation_to(f)
                }
                else{
                    remove_animation(f)
                }
                
                //add shadow
                f.body.layer.shadowColor = UIColor.black.cgColor
                f.body.layer.shadowOffset.width = 2
                f.body.layer.shadowOffset.height = 2
                f.body.layer.shadowRadius = 10
                f.body.layer.shadowOpacity = 0.8
            }
        }
    }
    
    public func fishSwim(){
        
        show_fish(true)
    }
    
    public func fishFloat(){
        
        show_fish(false)
        
    }
    
    private func add_animation_to(_ fish:Fish){
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = fish.path.cgPath
        
        animation.fillMode              = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.duration              = 20.0
        animation.repeatCount           = Float.infinity
        animation.timingFunction        = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        animation.rotationMode          = CAAnimationRotationMode.rotateAuto
        
        fish.body.layer.add(animation, forKey: fish.tag)
        
    }
    
    private func remove_animation(_ fish:Fish){
        fish.body.layer.removeAllAnimations()
    }
    
    var initialPanPos:CGPoint?
    @objc func pannedFish(sender:UIPanGestureRecognizer){
        if sender.state == .began {
            initialPanPos = sender.view!.center
            sender.view!.layer.removeAllAnimations()
        }
        
        
        if (initialPanPos!.x + sender.translation(in: self).x) > self.frame.width ||
            (initialPanPos!.y + sender.translation(in: self).y) > self.frame.height ||
            (initialPanPos!.x + sender.translation(in: self).x) < 0 ||
            (initialPanPos!.y + sender.translation(in: self).y) < 0
            {
            print("fish out of bounds")

            UIView.animate(withDuration: 1, delay: 0, options: .autoreverse, animations: {
                sender.view?.alpha = 0
            }) { (complete) in
                UIView.animate(withDuration: 0.25, animations: {
                    sender.view?.alpha = 1
                })
            }
                
                if sender.state == .ended  {
                    sender.view!.center = initialPanPos!
                }
            
            return
        }
            
        sender.view!.center.x = initialPanPos!.x + sender.translation(in: self).x
        sender.view!.center.y = initialPanPos!.y + sender.translation(in: self).y
        
        if sender.state == .ended && swimming  {
            fishSwim()
        }
    }
    
    public func filterFish(tagContains:String){
        filteredFish.removeAll()
        for f in self.fish {
            if f.tag.contains(tagContains){
                filteredFish.append(f)
            }
        }
    }
    
    public func filterGameFish(gameComplete:Bool){
        
        filteredFish.removeAll()
        
        for f in self.subviews {
            
            if let gameFish = f as? GameFishView {
                
                if gameFish.game_is_finished() == gameComplete {
                    
                    guard let index = fish.index(where: { (fishi) -> Bool in
                        return fishi.tag == gameFish.name
                    }) else { continue }
                    
                    filteredFish.append(fish[index])
                }
            }
        }
    }
    
    public func remove_all_fish(){
        self.fish.removeAll()
        for fish in self.subviews {
            if fish as? GameFishView != nil {
                fish.removeFromSuperview()
            }
        }
    }
}

struct Fish {
    var body:UIView
    var path:UIBezierPath
    var color:UIColor
    var tag:String
}
