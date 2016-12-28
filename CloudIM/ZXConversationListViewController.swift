//
//  ZXConversationListViewController.swift
//  Pods
//
//  Created by 朱星 on 2016/12/7.
//
//

import UIKit
import KYMenu
import PopMenu

class ZXConversationListViewController: RCConversationListViewController {
    
    //MARK: - 点击加号，弹出下拉菜单！
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        
        tankuang()
        //自定义转场动画   第1步
//        var  frame = (sender.value(forKey: "view") as AnyObject).frame
//        
//        frame?.origin.y = (frame?.origin.y)! + 30
        
        //第2步
//        let menuArray = [
//            KYMenuItem.init("创建讨论组", image: UIImage(named: "客服_highlighted"), target: self, action: #selector(ZXConversationListViewController.test1)),
//            KYMenuItem.init("加好友", image: UIImage(named: "right_menu_addFri"), target: self, action: #selector(ZXConversationListViewController.test1)),
//            KYMenuItem.init("扫一扫", image: UIImage(named: "right_menu_QR"), target: self, action: #selector(ZXConversationListViewController.test1)),
//            KYMenuItem.init("面对面快传", image: UIImage(named: "right_menu_facetoface"), target: self, action: #selector(ZXConversationListViewController.test1)),
//            KYMenuItem.init("收钱", image: UIImage(named: "right_menu_payMoney"), target: self, action: #selector(ZXConversationListViewController.test1))]
//        
//        //第3步
//        let options = OptionalConfiguration(
//            arrowSize: 9,               // arrow size
//            marginXSpacing: 7,          // MenuItem left and right margins
//            marginYSpacing: 9,          // MenuItem upper and lower margins
//            intervalSpacing: 25,        // MenuItemImage and MenuItemTitle
//            menuCornerRadius: 6.5,      // menu radius
//            maskToBackground: true,     // Whether to add translucent mask on the cover in the original View
//            shadowOfMenu: false,        // add menu is the shadow
//            hasSeperatorLine: true,     // set split line
//            seperatorLineHasInsets: false,                // Whether to leave the line on both sides of the Insets
//            textColor: Color(R: 0, G: 0, B: 0),           // menuItem font color
//            menuBackgroundColor: Color(R: 1, G: 1, B: 1)  // The menu background
//            
//        )
//        //第4步
//        KYMenu.show(in: self.view, from: frame!, menuItems: menuArray, withOptions: options)
    }

 
   
    
    override func viewDidLoad() {
        //重写显示相关的接口，必须先调用super，否则会屏蔽SDK默认的处理
        super.viewDidLoad()
        //设置需要显示哪些类型的会话
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue,
                                          RCConversationType.ConversationType_DISCUSSION.rawValue,
                                          RCConversationType.ConversationType_CHATROOM.rawValue,
                                          RCConversationType.ConversationType_GROUP.rawValue,
                                          RCConversationType.ConversationType_APPSERVICE.rawValue,
                                          RCConversationType.ConversationType_SYSTEM.rawValue])
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION.rawValue,RCConversationType.ConversationType_GROUP.rawValue])
        self.refreshConversationTableViewIfNeeded()
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(showMenu(_:)))
        self.navigationController?.navigationItem.rightBarButtonItem = item
        
        
    }

    //MARK: - 点击单元格跳转的方法
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        
        ZXLog(message: model.targetId)
        ZXLog(message: model.conversationTitle)
        ZXLog(message: model.senderUserId)
       
        let conVC = ZXConversationViewController()
        conVC.targetId = model.targetId
        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        conVC.title = model.conversationTitle
        self.navigationController?.pushViewController(conVC, animated: true)
        conVC.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    func test1()  {
        ZXLog(message: "朱星")
    }
    
    func tankuang() {
        let items = [MenuItem(title: "客服", iconName: "客服_highlighted", glow: UIColor.orange, index: 0),
                     MenuItem(title: "朱星聊天", iconName: "tabbar_huihua_highlighted", glow: UIColor.orange, index: 1),
                     
                     MenuItem(title: "通讯录", iconName: "tabbar_profile_highlighted", glow: UIColor.orange, index: 2),
                     MenuItem(title: "关于", iconName: "关于_highlighted", glow: UIColor.orange, index: 3)
        ]
        
        guard let menu = PopMenu(frame: self.view.bounds, items: items) else {
            return
        }
        menu.menuAnimationType = .netEase
        
        if menu.isShowed {
            return
        }
        menu.didSelectedItemCompletion = {(selectedItem: MenuItem?) -> Void in
            
            switch selectedItem!.index {
            case 1:
                let conVC = ZXConversationViewController()
                conVC.conversationType = RCConversationType.ConversationType_PRIVATE
                conVC.title = "小波"
                self.navigationController?.pushViewController(conVC, animated: true)
                self.tabBarController?.tabBar.isHidden = false
                
            default:
                print(selectedItem?.title ?? -1)
            }
            
        }
        menu.perRowItemCount = 2
        menu.show(at: self.view)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    

}
