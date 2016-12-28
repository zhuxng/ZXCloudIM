//
//  LoginViewController.swift
//  CloudIM
//
//  Created by 朱星 on 2016/12/24.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import JSAnimatedImagesView
import AVOSCloud
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var wallPaperImageView: RCAnimatedImagesView!
    
    
    //用户名
    @IBOutlet weak var userName: UITextBox!
    
    //密码
    @IBOutlet weak var UserPassWord: UITextBox!
    
//    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wallPaperImageView.delegate = self
        wallPaperImageView.startAnimating()
        
    }
    @IBAction func regiterBTN(_ sender: Any) {
        
        
//         self.performSegue(withIdentifier: "ToRegister", sender: nil)
        
    }
    @IBAction func LoginBtn(_ sender: Any) {
    
        if (userName.text != nil) && (UserPassWord.text != nil) {
            
            let user = AVUser(className: "ZXUser")
            user.signUpInBackground({ (success, error) in
                if (error != nil) {
                    SVProgressHUD.showError(withStatus: "登录失败")
                }else {
                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    self.performSegue(withIdentifier: "toConversationList", sender: nil)
                }
            })
            
        }
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         UIView.animate(withDuration: 1) {
            self.loginStackView.axis = UILayoutConstraintAxis.vertical
        }
        navigationController?.navigationBar.isHidden = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRegister" {
            
            let vc = segue.destination as? ZXRegisterViewController
            vc?.hander = {
                (str: String, str2: String) -> Void in
                self.userName.text = str
                self.UserPassWord.text = str2
            }
            
        }

        
    }

}


//MARK: -JSAnimatedImagesViewDataSource
extension LoginViewController: RCAnimatedImagesViewDelegate {
    func animatedImagesNumber(ofImages animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(_ animatedImagesView: RCAnimatedImagesView!, imageAt index: UInt) -> UIImage! {
        
        
        return UIImage(named: "\(index + 1)")
    }
}
