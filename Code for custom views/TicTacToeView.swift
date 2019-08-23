//
//  TicTacToeView.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 31.12.17.
//  Copyright © 2017 LCR. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TicTacToeView: UIView {

    enum Player {
        case red
        case green
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        for coin in bitcoins {
            coin.image = default_player_img
            coin.alpha = 0
            coin.layer.masksToBounds = true
            coin.layer.cornerRadius = coin.frame.height/2
            self.addSubview(coin)
        }
    }
    
    init(){
        super.init(frame: CGRect())
        for coin in bitcoins {
            coin.image = default_player_img
            coin.alpha = 0
            coin.clipsToBounds = true
            self.addSubview(coin)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let labels:[UILabel] = [UILabel(),UILabel(),UILabel(),
                            UILabel(),UILabel(),UILabel(),
                            UILabel(),UILabel(),UILabel()]
    
    override func draw(_ rect: CGRect) {
        
        // **** Drawing Grid ****
        
        let hStep:CGFloat = rect.width/3
        let vStep:CGFloat = rect.height/3
        let path:UIBezierPath = UIBezierPath()
        
        // **** vertical lines ****
        
        path.move(to: CGPoint(x:hStep, y:0))
        path.addLine(to: CGPoint(x:hStep, y:rect.height))
        path.move(to: CGPoint(x:2*hStep, y:0))
        path.addLine(to: CGPoint(x:2*hStep, y:rect.height))
        
        // **** horizontal lines ****
        path.move(to: CGPoint(x:0, y:vStep))
        path.addLine(to: CGPoint(x:rect.width, y:vStep))
        path.move(to: CGPoint(x:0,y:2*vStep))
        path.addLine(to: CGPoint(x:rect.width, y:2*vStep))
        
        // **** stroke ****
        
        path.lineWidth = lineWidth
        lineColor.withAlphaComponent(self.alphaComponent).setStroke()
        path.stroke()
        
        // **** Initializing Labels here because I need the geometric info given in the draw function ****
        
        for label in labels {
            label.frame.size = CGSize(width:hStep,height:vStep*0.25)
            label.textAlignment = .center
            label.textColor = lineColor
            let index = labels.index(of: label)!
            label.text = "\(score(field: index).0)/\(score(field: index).1)"
            self.addSubview(label)
        }
        
        // **** Labels containing score information ****
        
        labels[0].frame.origin = CGPoint(x:0,y:vStep*0.75)
        labels[1].frame.origin = CGPoint(x:hStep,y:vStep*0.75)
        labels[2].frame.origin = CGPoint(x:2*hStep,y:vStep*0.75)
        
        labels[3].frame.origin = CGPoint(x:0,y:vStep*1.75)
        labels[4].frame.origin = CGPoint(x:hStep,y:vStep*1.75)
        labels[5].frame.origin = CGPoint(x:2*hStep,y:vStep*1.75)
        
        labels[6].frame.origin = CGPoint(x:0,y:vStep*2.75)
        labels[7].frame.origin = CGPoint(x:hStep,y:vStep*2.75)
        labels[8].frame.origin = CGPoint(x:2*hStep,y:vStep*2.75)
        
        // **** Coins representing the played fields ***
        
        bitcoins[0].frame.origin = CGPoint(x:vStep*0.125,y:vStep*0.05)
        bitcoins[1].frame.origin = CGPoint(x:hStep+vStep*0.125,y:vStep*0.05)
        bitcoins[2].frame.origin = CGPoint(x:2*hStep+vStep*0.125,y:vStep*0.05)
        
        bitcoins[3].frame.origin = CGPoint(x:vStep*0.125,y:vStep*1.05)
        bitcoins[4].frame.origin = CGPoint(x:hStep+vStep*0.125,y:vStep*1.05)
        bitcoins[5].frame.origin = CGPoint(x:2*hStep+vStep*0.125,y:vStep*1.05)
        
        bitcoins[6].frame.origin = CGPoint(x:vStep*0.125,y:2.05*vStep)
        bitcoins[7].frame.origin = CGPoint(x:hStep+vStep*0.125,y:2.05*vStep)
        bitcoins[8].frame.origin = CGPoint(x:2*hStep+vStep*0.125,y:2.05*vStep)
        
        // **** adjust the sizes ****
        
        for coin in bitcoins {
            coin.frame.size = CGSize(width:vStep*0.7,height:vStep*0.7)
            coin.layer.cornerRadius = coin.frame.height/2
        }
        
    }
    
    //images that are being displayed
    private
    var default_opponent_img:UIImage = Design.default_profile_image_red
    private
    var default_player_img:UIImage = Design.default_profile_image_blue
    var player_img:UIImage?
    var opponen_img:UIImage?
 
    var last_touched:UInt?
    
    var indicator:NVActivityIndicatorView?
    
    var myTurn:Bool {
        get {
            if assistent != nil {
                //print("setting assistent in view")
                return assistent!.myTurn}
            else { print("assistant in view is empty") ; return true }
        }
    }
    var lineColor:UIColor = .black
    var lineWidth:CGFloat = 1
    var alphaComponent:CGFloat = 1
    
    var assistent:DuelGameAssistent? {
        
        set{
            self.assi = newValue
            connect_userfeedback()
        }
        get{
            return assi
        }
    }
    
    private var assi:DuelGameAssistent?
    
    private
    var shadeColor:UIColor {
        get {
            switch player {
            case .red:
                return UIColor.red
            case .green:
                return UIColor.green
            }
        }
    }
    
    var player:Player = .red
    
    //To-Do write class for every tictactoe cell
    //randomly save a set a set of questions and give them to opponent
    
    //returns info if a field can be played or not
    var possible_fields:[Bool] = [true, true, true,
                                  true, true, true,
                                  true, true, true]
    
    //made it private so no different colors can be set
    private let green_fields:[CGColor] = [UIColor.green.cgColor,UIColor.green.cgColor,UIColor.green.cgColor,
                                         UIColor.green.cgColor,UIColor.green.cgColor,UIColor.green.cgColor,
                                         UIColor.green.cgColor,UIColor.green.cgColor,UIColor.green.cgColor]
    
    private let red_fields:[CGColor] = [UIColor.red.cgColor,UIColor.red.cgColor,UIColor.red.cgColor,
                                        UIColor.red.cgColor,UIColor.red.cgColor,UIColor.red.cgColor,
                                        UIColor.red.cgColor,UIColor.red.cgColor,UIColor.red.cgColor]
    
    private var colors:[CGColor] = [UIColor.clear.cgColor,UIColor.clear.cgColor,UIColor.clear.cgColor,
                                    UIColor.clear.cgColor,UIColor.clear.cgColor,UIColor.clear.cgColor,
                                    UIColor.clear.cgColor,UIColor.clear.cgColor,UIColor.clear.cgColor]
    
    lazy var message_label:UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        self.addSubview(label)
        label.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -30).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true

        label.backgroundColor = .clear
        label.alpha = 0

        return label
    }()
    
    func connect_userfeedback(){
        
        if(assistent != nil && assistent!.bot_mode){
            _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(simulateTap), userInfo: nil, repeats: true)
        }
        else{
            // **** add the tap gesture recognozer for user interaction ****
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
            self.addGestureRecognizer(tap)
        }
    }
    
    //sets the shadow color to an imageView
    func set_field_won(_ field:Int){
       
        self.bitcoins[field].alpha = 1
        self.colors[field] = green_fields[field]
        self.bitcoins[field].image = player_img ?? default_player_img
        self.set_background_for_coins()
       
    }
    
    func set_field_lost(_ field:Int){
        
        self.bitcoins[field].alpha = 1
        self.colors[field] = self.red_fields[field]
        self.bitcoins[field].image = opponen_img ?? default_opponent_img
        self.set_background_for_coins()
    
    }
    
    func set_field_tie(_ field:Int){
        
        self.bitcoins[field].alpha = 1
        self.colors[field] = UIColor.clear.cgColor
        self.set_background_for_coins()
        
    }
    
    //returns the current shadow color of a field
    func get_field_color(_ field:Int)->CGColor{
        return colors[field]
    }
    
    //info who got what right or wrong
    private func score(field:Int)->(String,String) {
        
        var me:Int = 0
        var him:Int = 0
        
        if colors[field] == green_fields[field] { me = 1 }
        if colors[field] == red_fields[field] { him = 1 }
        
        if !(assistent?.game?.answer_values.isEmpty ?? true) {
            
            if assistent?.game?.answer_values[0].field[field].correct == 1 {
                me = 1
            }
            if assistent?.game?.answer_values[1].field[field].correct == 1 {
                him = 1
            }
        }
        
        let score = ("\(me)","\(him)")

        return score
    }
    
    //the image views, one for every field
    //..will be having bitcoins
    //..can also have profile pictures
    private var bitcoins:[UIImageView] = [UIImageView(),UIImageView(),UIImageView(),
                                          UIImageView(),UIImageView(),UIImageView(),
                                          UIImageView(),UIImageView(),UIImageView()]
    

    
    // a tapp on the field
    // advantage of using this rather to buttons is:
    // ..easier to block touches
    // ..more controll . for example for animations
    @objc func tapped(sender:UITapGestureRecognizer){
        
        if !myTurn {
            print("sorry not your turn")
            show_message("Warte noch auf den Gegenspieler")
            return }
        
        let touchpoint = sender.location(in: self)
        
        guard let touchedCell = touched_cell(touchpoint: touchpoint) else { return }
        
        last_touched = touchedCell
        
        if possible_fields[Int(touchedCell)] == false {
            print("you cannot play this field now")
            return
        }
        
        //when a user tapped a field the passed question MUST be reset
        //passed questions only make sense when a user follows up with his turn
        assistent?.card_content.pass_questions_by_id([])
        
        //start the quiz action view controller
        segueToVC()
        
    }
    
    //gives info on what cell has been touched
    //..can be replaced by gesture recognizer on bitcoins
    //..bitcoins can also be changed into buttons -> will be hard with animations though <-
    func touched_cell(touchpoint:CGPoint)->UInt?{
        
        for coin in bitcoins {
            let vrange = CGSize(width:coin.frame.origin.y,height:coin.frame.origin.y+coin.frame.height)
            let hrange = CGSize(width:coin.frame.origin.x,height:coin.frame.origin.x+coin.frame.width)
            
            if touchpoint.y >= vrange.width && touchpoint.y <= vrange.height
                && touchpoint.x >= hrange.width && touchpoint.x <= hrange.height {
                
                let index:Int = bitcoins.index(of: coin)!

                print("touched cell: \(index)")
                return UInt(index)
            }
        }
        
        return nil
    }
    
    func set_background_for_coins(){
        for i in (0..<bitcoins.count) {
            bitcoins[i].layer.shadowColor = colors[i]
            bitcoins[i].layer.shadowOpacity = 0.75
            bitcoins[i].layer.shadowRadius = 15
            
        }
    }
    
    //view controller we want to segue to
    //..this will probably be the view controller of the card action
    var destinationViewController:QuizActionViewController?
    //view controller which is responsible for the tictactoe view
    var rootViewController:UIViewController?
    
    //show the action game view controller with questions
    func segueToVC(){
        
        guard let last_touched_UInt = last_touched else { return }
        if assistent?.game?.chapter_map[Int(last_touched_UInt)] == nil { return }
        
        print("\nthe picked chapter is chapter_\(assistent!.game!.chapter_map[Int(last_touched!)]!)\n")
        assistent!.card_content.toChapter(chapter: assistent!.game!.chapter_map[Int(last_touched!)]!)
        
        if destinationViewController != nil {
            destinationViewController = QuizActionViewController() }
        else { return }
        
        if assistent != nil {
            destinationViewController!.duelAssistent = assistent! }
        
        destinationViewController!.duelMode = true
        destinationViewController!.backImage = Design.duellCardbackImage
        
        if destinationViewController != nil && rootViewController != nil {
            rootViewController?.present(destinationViewController!, animated: false, completion: nil)
        }
    }
    
    @objc func simulateTap(sender:Timer){
        
        if(!myTurn){
            return
        }
        
        print("the bots turn now -> will simulate tap")
        
        var random = arc4random_uniform(UInt32(possible_fields.count))
        var it = 0
        
        while(possible_fields[Int(random)] == false && it < 1000){
            random = arc4random_uniform(UInt32(possible_fields.count))
            it += 1
        }
        
        if(it >= 1000){
            fatalError("not possible there is an error!")
        }
        
        last_touched = UInt(random)
        
        //when a user tapped a field the passed question MUST be reset
        //passed questions only make sense when a user follows up with his turn
        assistent?.card_content.pass_questions_by_id([])
        
        //start the quiz action view controller
        segueToVC()
    }
    
    func show_message(_ message:String){
        
        if Thread.isMainThread {
            
            message_label.text = message
            
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
                self.message_label.alpha = 1
            }) { (completion) in
                if completion {
                    UIView.animate(withDuration: 1, animations: {
                        self.message_label.alpha = 0
                    })
                    
                }
            }
            
        }
        else{
            DispatchQueue.main.async {
                self.message_label.text = message
                
                UIView.animate(withDuration: 1, delay: 0, options: .autoreverse, animations: {
                    self.message_label.alpha = 1
                }) { (completion) in
                    if completion {
                        self.message_label.alpha = 0
                    }
                }
            }
        }
    }

}
