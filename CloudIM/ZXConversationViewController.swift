//
//  ZXConversationViewController.swift
//  CloudIM
//
//  Created by 朱星 on 2016/12/6.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class ZXConversationViewController: RCConversationViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.targetId = "zhuxing2"
      
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        imageView.image = UIImage(named: "Snip20161207_6")
        self.conversationMessageCollectionView.backgroundView = imageView
        self.tabBarController?.tabBar.isHidden = true
        
        
        
    }

//    
//    override func willDisplayMessageCell(_ cell: RCMessageBaseCell!, at indexPath: IndexPath!) {
//        if cell.isMember(of: RCTextMessageCell.self) {
//            let textCell = RCTextMessageCell()
//            let textLable = textCell.textLabel as UILabel
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
//            
//            imageView.image = UIImage(named: "Snip20161207_6")
//            textCell.bubbleBackgroundView = imageView
//            textLable.textColor = UIColor.orange
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
