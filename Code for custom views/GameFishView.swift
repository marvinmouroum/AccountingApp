//
//  GameFishView.swift
//  Prototype
//
//  Created by MacBook Pro Accounting  on 03.02.18.
//  Copyright © 2018 LCR. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class GameFishView:UIButton {
    
    var name:String  {
        get {
            if self.gameID == nil { return "no name" }
            return self.gameID!
        }
        set{
            self.gameID = newValue
            fill_fish()
        }
    }
    
    func set_duelGame(_ game:DuelGame){
        self.gameID = game._gameId
        self.duelGame = game
        fill_fish()
    }
    
    private var gameID:String?
    
    private var duelGame:DuelGame?
    
    public func game_is_finished()->Bool {
        
        if self.duelGame == nil { return false }
        
        return self.duelGame!._gameState!.boolValue
    }
    
    private func fill_fish(){
        DispatchQueue.global(qos: .userInitiated).async {
            self.get_game()
            self.setImage()
            self.setInitial()
            
            //if waiting for review make it obvious
            if !self.opponent_accepted(){
                DispatchQueue.main.async {
                    self.alpha = 0.5
                }
            }
        }
    }
    
    private func get_game(){
    
        if gameID == nil { return }
        
        if duelGame != nil { return }
        
        self.duelGame = AdressBook._backend.game.load_game(id:self.gameID!)
        
    }
    
    lazy var indicator_view:NVActivityIndicatorView = {
        
        var width:CGFloat!
        var center:CGPoint!
        var indicator:NVActivityIndicatorView!
        
        if !Thread.isMainThread{
            DispatchQueue.main.sync {
                width = min(self.frame.width/2,self.frame.height)
                center = CGPoint(x:self.frame.width/2, y:self.frame.height/2)
                
                let indicator_size = CGSize(width:width,height:width)
                let indicator_origin = CGPoint(x:center.x-width/2,y:center.y-width/2)
                indicator = NVActivityIndicatorView(
                    frame: CGRect(origin:indicator_origin, size:indicator_size),
                    type: .ballScaleRippleMultiple,
                    color: UIColor.white, padding: nil)
            }
        }
        else{
            width = min(self.frame.width/2,self.frame.height)
            center = CGPoint(x:self.frame.width/2, y:self.frame.height/2)
            
            let indicator_size = CGSize(width:width,height:width)
            let indicator_origin = CGPoint(x:center.x-width/2,y:center.y-width/2)
            indicator = NVActivityIndicatorView(
                frame: CGRect(origin:indicator_origin, size:indicator_size),
                type: .ballScaleRippleMultiple,
                color: UIColor.white, padding: nil)
        }
        
        return indicator
    }()
    
    private func setImage(){
        
        if Thread.isMainThread{
            self.addSubview(indicator_view)
            indicator_view.startAnimating()
        }
        else{
            DispatchQueue.main.sync {
                self.addSubview(self.indicator_view)
                self.indicator_view.startAnimating()
            }
        }
        
        
        if duelGame == nil { return }
        
        DispatchQueue.main.sync {
           
            guard let myself = AdressBook.current_user()?.username else { return }
           
            var image:UIImage? = nil
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                if self.duelGame!._player1 == myself { image = AdressBook.get_profile_image_from(self.duelGame!._player2!) }
                    
                else { image = AdressBook.get_profile_image_from(self.duelGame!._player1!) }
                
                DispatchQueue.main.async {
                    self.clipsToBounds = true
                   // self.image = image
                    self.setBackgroundImage(image, for: .normal)
                    self.indicator_view.stopAnimating()
                }
                
            }
            
            
        }
        
    }
    
    private func setInitial(){
        
        DispatchQueue.main.sync {
            
            guard let myself = AdressBook.current_user()?.username else { return }
            
            
            self.titleLabel?.font = UIFont(name: Design.boldFont, size: self.frame.height - 5)
            self.setTitleColor(Design.darkBlue.withAlphaComponent(0.5), for: .normal)
            self.setTitleColor(Design.darkBlue, for: .highlighted)
            self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            
            if duelGame!._player1 == myself {
                //initial.text = String(duelGame!._player2!.first!)
                self.setTitle(String(duelGame!._player2!.first!), for: .normal)
                
            }
                
            else {
                //initial.text = String(duelGame!._player1!.first!)
                self.setTitle(String(duelGame!._player1!.first!), for:.normal)
            }
            
        }
        
    }
    
    @objc func pressed(sender: UIButton){
        print("pressed game: \(self.gameID ?? "N/A")")
    }
    
    static func create_bot(for player:String)->GameFishView {
        let game = DuelGame.create_new_duel_game_shell(1)
        game._player1 = player
        game._player2 = "Bot"
        game._gameId = "duelGame_\(game._player1!)_\(game._player2!)"
        var bot:GameFishView?
        
        if(Thread.isMainThread){
            bot = GameFishView()

        }
        else{
            DispatchQueue.main.sync {
                bot = GameFishView()
            }
            
        }
        bot!.duelGame = game
        bot!.gameID = game._gameId
        bot!.setInitial()
        print("created a gameFishView for a Bot")
        return bot!
    }
    
    func get_opponent_name()->String {
        guard let myname = AdressBook.current_user()?.username else { return "No Name" }
        
        guard let game = duelGame else { return "No Name" }
        
        if (game._player1 == myname) { return  game._player2! }
        else                         { return  game._player1! }
    }

    func get_opponent()->User? {
        guard let myname = AdressBook.current_user()?.username else { return nil }
        
        guard let game = duelGame else { return nil }
        
        if (game._player1 == myname) { return  AdressBook._backend.user.get_user(username: game._player2!) }
        else                         { return  AdressBook._backend.user.get_user(username: game._player1!) }
        
    }
    
    private func who_am_i()->Int{
        if duelGame?._player1 == AdressBook.current_user()?.username {
            return 0
        }
        
        return 1
    }
    
    func i_accepted()->Bool {
        return duelGame?._accepted?[who_am_i()].boolValue ?? false
    }
    
    func opponent_accepted()->Bool {
        return duelGame?._accepted?[1-who_am_i()].boolValue ?? false
    }
}
