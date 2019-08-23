//
//  DuelUserTableViewCell.swift
//  Prototype_2
//
//  Created by Marvin Mouroum on 16.02.19.
//  Copyright © 2019 LCR. All rights reserved.
//

import UIKit

class DuelUserTableViewCell: UITableViewCell {

    
    var user:User?
    var maximized:Bool = false
    
    private let default_image:UIImage = UIImage(named: "defaultProfileImageBlue")!
    
    var profile_image:UIImage?
    
    var name:String? = "Maxi_Musti"
    var rank:Int     = 0
    var online:String = "0 n/a"
    
    private var expanded:Bool = false
    
    lazy var profile_imageView:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        
        profile_image_top = view.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height*0.1)
        profile_image_top?.isActive = false
        profile_image_center = view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        profile_image_center?.isActive = true
        
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.075).isActive = true
        view.heightAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.height*0.075).isActive = true
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.height*0.025).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.layer.borderColor = Design.textGrayDark.cgColor
        view.layer.borderWidth = 1
        
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var name_label:UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = Design.darkBlue
        label.font = UIFont(name: Design.defaultFont, size: Design.smallFontSize)
        label.backgroundColor = .clear
        
        self.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: profile_imageView.trailingAnchor, constant: 5).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.05*self.frame.height).isActive = true
        label.bottomAnchor.constraint(equalTo: profile_imageView.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0.075*self.frame.width-5).isActive = true
        
        return label
    }()
    
    lazy var rang_label:UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = Design.textGrayDark
        label.font = UIFont(name: Design.defaultFont, size: Design.smallFontSize)
        
        self.addSubview(label)
        
        rang_top_1 = label.bottomAnchor.constraint(equalTo: name_label.bottomAnchor)
        rang_top_2 = label.topAnchor.constraint(equalTo: name_label.bottomAnchor)
        
        rang_trailing = label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0.075*self.frame.width-5)
        rang_leading = label.leadingAnchor.constraint(equalTo: name_label.leadingAnchor)
        
        rang_top_2?.isActive = false
        rang_leading?.isActive = false
        rang_top_1?.isActive = true
        rang_trailing?.isActive = true
        
        
        label.heightAnchor.constraint(equalToConstant: Design.smallFontSize * 1.1).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        
        return label
    }()
    
    lazy var rang_value_label:UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = Design.textGrayDark
        label.font = UIFont(name: Design.defaultFont, size: Design.smallFontSize)
        
        self.addSubview(label)
        
        label.topAnchor.constraint(equalTo: name_label.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0.075*self.frame.width-5).isActive = true
        label.heightAnchor.constraint(equalToConstant: Design.smallFontSize * 1.1).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        
        return label
    }()
    
    lazy var online_value_label:UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = Design.darkBlue
        label.font = UIFont(name: Design.defaultFont, size: Design.smallFontSize)
        
        return label
    }()
    
    lazy var online_label:UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = Design.darkBlue
        label.font = UIFont(name: Design.defaultFont, size: Design.smallFontSize)
        
        return label
    }()
    
    lazy var play_button:UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Design.darkBlue
        button.setTitle("Spielen", for: .normal)
        button.showsTouchWhenHighlighted = true
        
        return button
    }()
    
    lazy var profile_button:UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Design.darkBlue
        button.setTitle("Profil", for: .normal)
        button.showsTouchWhenHighlighted = true
        
        return button
    }()
    
    var profile_image_center:NSLayoutConstraint?
    var profile_image_top:NSLayoutConstraint?
    
    var name_center:NSLayoutConstraint?
    var name_left:NSLayoutConstraint?
    
    var rang_top_1:NSLayoutConstraint?
    var rang_top_2:NSLayoutConstraint?
    var rang_trailing:NSLayoutConstraint?
    var rang_leading:NSLayoutConstraint?
    
    var table:UITableView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("initializing \(reuseIdentifier)")
        
        self.backgroundColor = .clear
        
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        
        self.textLabel?.backgroundColor = .clear
        
    }
    
    func further_init(_ user:User) {
        
        self.user = user
        
        self.name = user._userName ?? "Maxi_Musti"
        self.rank = Int(truncating: user._rank ?? 0)
        
        if rank == 0 || rank == 1000 {
            DispatchQueue.global(qos: .userInitiated).async {
                self.rank = Rank.of_user(user)
                DispatchQueue.main.async {
                    self.rang_value_label.text   = String(self.rank)
                    self.layoutIfNeeded()
                    self.setNeedsDisplay()
                }
            }
        }
        
        let data = make_last_online_time()
        self.online = String(data.0) + " " + data.1
        
        set_data()
        
    }
    
    override func draw(_ rect: CGRect) {
        
        let rectN:CGRect = CGRect(x: rect.width * 0.05, y: rect.height * 0.05,
                                 width: rect.width * 0.9, height: rect.height * 0.9)
        let background = UIBezierPath(roundedRect: rectN, byRoundingCorners: .allCorners, cornerRadii: CGSize(width:5,height:5))
        Design.lightBlue.setFill()
        background.fill()
        
        let line = UIBezierPath()
        line.move(to: CGPoint(x: profile_imageView.frame.origin.x + profile_imageView.frame.width ,
                              y: profile_imageView.frame.origin.y + profile_imageView.frame.height/2))
        line.addLine(to: CGPoint(x:rect.width - profile_imageView.frame.width - profile_imageView.frame.origin.x,
                                 y: profile_imageView.frame.origin.y + profile_imageView.frame.height/2))
        
        line.lineWidth = profile_imageView.layer.borderWidth
        
        Design.textGrayDark.setStroke()
        
        line.stroke()
        
        profile_imageView.layer.cornerRadius = profile_imageView.frame.height/2
        play_button.layer.cornerRadius = play_button.frame.height/2
        profile_button.layer.cornerRadius = profile_button.frame.height/2
        
        set_data()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.user = AdressBook._backend.user.get_user(username: AdressBook.current_user()?.username ?? "Marvin") ?? User()
        
        super.init(style: .default, reuseIdentifier: "Test")
        
        self.name = user?._userName ?? "Maxi_Musti"
        self.rank = Int(truncating: user?._rank ?? 0)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.rank = Rank.of_user(self.user!)
        }
        
        let data = make_last_online_time()
        self.online = String(data.0) + " " + data.1
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
        
        set_data()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func make_last_online_time() -> (Int,String) {
        
        if let online = user?._online {
            if let timeinterval = Double(exactly:online){
                
                let seconds = Date().timeIntervalSince1970 - timeinterval
                
                if seconds >= 60 && seconds < 60*60 {
                    return (Int(seconds / 60), "min")
                }
                
                else if seconds >= 60*60 && seconds < 60*60*24 {
                    return (Int(seconds / (60*60)), "h")
                }
                
                else if seconds >= 60*60*24 && seconds < 60*60*24*30 {
                    return (Int(seconds / (60*60*24)), "Tag(e)")
                }
                
                else if seconds >= 60*60*24*30 && seconds < 60*60*24*30*12 {
                    return (Int(seconds / (60*60*24*30)), "Monat(e)")
                }
                
                else if seconds >= 60*60*24*30*12 {
                    return (Int(seconds / (60*60*24*30*12)), "Jahr(e)")
                }
                else {
                    return (Int(seconds),"s")
                }
            }
        
            
        }
        
        return (0,"n/a")
    }
    
    //expanded - imploded
    
    private func change_layout(){
        
        if expanded {
            profile_image_center?.isActive = false
            profile_image_top?.isActive = true
            
            rang_top_1?.isActive = false
            rang_top_2?.isActive = true
            
            rang_trailing?.isActive = false
            rang_leading?.isActive = true
            
            name_left?.isActive = false
            name_center?.isActive = true
            
            rang_value_label.textColor = Design.darkBlue
            rang_label.textColor       = Design.darkBlue
        }
        
        else {
            profile_image_center?.isActive = true
            profile_image_top?.isActive = false
            
            rang_top_1?.isActive = true
            rang_top_2?.isActive = false
            
            rang_trailing?.isActive = true
            rang_leading?.isActive = false
            
            name_left?.isActive = true
            name_center?.isActive = false
            
            rang_value_label.textColor = Design.textGrayDark
            rang_label.textColor       = Design.textGrayDark
        }
    }
    
    private func add_labels() {
        
        self.addSubview(online_label)
        
        online_label.topAnchor.constraint(equalTo: rang_label.bottomAnchor).isActive = true
        online_label.leadingAnchor.constraint(equalTo: rang_label.leadingAnchor).isActive = true
        online_label.heightAnchor.constraint(equalToConstant: Design.smallFontSize * 1.1).isActive = true
        online_label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        
        self.addSubview(online_value_label)
        
        online_value_label.topAnchor.constraint(equalTo: rang_value_label.bottomAnchor).isActive = true
        online_value_label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0.075*self.frame.width-5).isActive = true
        online_value_label.heightAnchor.constraint(equalToConstant: Design.smallFontSize * 1.1).isActive = true
        online_value_label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        
    }
    
    private func add_buttons(){
        
        self.addSubview(play_button)
        
        play_button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.075).isActive = true
        play_button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        play_button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        play_button.topAnchor.constraint(greaterThanOrEqualTo: self.online_label.bottomAnchor, constant:10).isActive = true
        play_button.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -self.frame.height*0.075).isActive = true
        
        self.addSubview(profile_button)
        
        profile_button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.frame.width * 0.075).isActive = true
        profile_button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        profile_button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        profile_button.centerYAnchor.constraint(equalTo: play_button.centerYAnchor).isActive = true
    }
    
    private func remove_buttons(){
        profile_button.removeFromSuperview()
        play_button.removeFromSuperview()
    }
    
    private func remove_labels() {
        online_value_label.removeFromSuperview()
        online_label.removeFromSuperview()
    }
    
    private func set_data(){
        //inititate the view in main thread and assign default immage
        self.profile_imageView.image = self.profile_image ?? self.default_image
        self.name_label.text         = self.name
        self.rang_label.text         = "Rang"
        self.rang_value_label.text   = String(self.rank)
        self.online_label.text       = "zuletzt online"
        self.online_value_label.text = self.online
    }
    
    func set_imploded(){
        expanded = false
        remove_labels()
        remove_buttons()
        change_layout()
        set_data()
    }
    
    func set_exploded(){
        expanded = true
        add_labels()
        add_buttons()
        change_layout()
        set_data()
    }
    
    func im_explode(){
        
        if expanded { set_imploded() }
        else { set_exploded() }
    }
    
    var desired_height:CGFloat {
        
        if expanded { return 170 }
        else { return 75 }
    }
    
    func expanded_state()->Bool {
        return self.expanded
    }

}
