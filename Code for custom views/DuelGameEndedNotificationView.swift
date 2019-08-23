//
//  DuelGameEndedNotificationView.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 10.03.18.
//  Copyright © 2018 LCR. All rights reserved.
//

import UIKit

// view that notifys user when a game was won or ended
class DuelGameEndedNotificationView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(winner: String) {
        super.init(frame: CGRect())
        self.winner = winner
        label.text = winner_message
        secondary_init()
        
    }
    
    init(quitter: String) {
        super.init(frame: CGRect())
        self.quitter = quitter
        label.text = abort_message
        secondary_init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func secondary_init(){
        self.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        place_background()
        place_label()
    }
    
    var winner:String?  //name of the winner
    var quitter:String? // name of the quitter
    
    var winner_message:String {
        get {
            guard let name = winner else { return "Das Spiel wurde gewonnen" }
            return name + " hat das Spiel gewonnen"
        }
    }
    
    var abort_message:String {
        get {
            guard let name = winner else { return "Das Spiel wurde abgebrochen" }
            return name + " hat das Spiel abgebrochen"
        }
    }
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Design.boldFont, size: Design.normalFontSize)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Design.textGrayDark
        return label
    }()
    
    func place_label(){
        
        self.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    lazy var background_blur:UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let eview = UIVisualEffectView(effect: effect)
        eview.translatesAutoresizingMaskIntoConstraints = false
        return eview
    }()
    
    func place_background(){
        
        self.addSubview(background_blur)
        
        background_blur.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        background_blur.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        background_blur.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        background_blur.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    private var parent_vc:DuelActionViewController?
    
    var viewController:DuelActionViewController? {
        get {
            return parent_vc
        }
        set {
            self.parent_vc = newValue
            tap = UITapGestureRecognizer(target: self, action: #selector(react_to_user))
            add_gesture()
        }
    }
    
    lazy var tap:UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        return tap
    }()

    @objc func close_the_game(_ sender: UITapGestureRecognizer){
        parent_vc?.dismiss(animated: true, completion: {
            print("dismissed the game")
        })
    }
    
    func close_the_view(){
        self.removeFromSuperview()
    }
    
    @objc func react_to_user(_ sender:UITapGestureRecognizer) {
        
        let alert = UIAlertController(title: "Das Spiel ist zuende.", message: "Was möchtest du tun?", preferredStyle: .alert)
        
        let action_ok = UIAlertAction(title: "Zeig mir das Spielfeld", style: .default) { (action) in
            self.close_the_view()
        }
        
        let action_no = UIAlertAction(title: "Zurück zur Übersicht", style: .default) { (action) in
            self.close_the_game(sender)
        }
        
        alert.addAction(action_ok)
        alert.addAction(action_no)
        
        self.parent_vc?.present(alert, animated: true, completion: nil)
    }
    
    func add_gesture(){
        self.addGestureRecognizer(tap)
    }
    
    func stretch_out(){
        
        if superview == nil { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: superview!.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview!.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview!.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview!.trailingAnchor).isActive = true
    }
}
