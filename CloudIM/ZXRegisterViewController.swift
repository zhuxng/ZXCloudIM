//
//  ZXRegisterViewController.swift
//  CloudIM
//
//  Created by 朱星 on 2016/12/24.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import Toast_Swift
import SVProgressHUD
import AJWValidator
import AVOSCloud

class ZXRegisterViewController: UITableViewController {
    

    
    @IBOutlet var loginTextfield: [UITextField]!

    @IBOutlet weak var useTextField: UITextBox!
    
    @IBOutlet weak var passwordTextField: UITextBox!
    
    @IBOutlet weak var emailTextField: UITextBox!
    
    
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextfield: UITextField!
    
    @IBOutlet weak var completedBTI: UIBarButtonItem!
    
    
    var possibleInputs: ZXInputs = []
    
    var hander: ((_ ST1:String,_ ST2: String) -> Void)!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()

        self.title = "新用户注册"
//        completedBTI.isEnabled = true3
        self.navigationController?.navigationBar.isHidden = false
        isAllCorrect()
    }
   
    @IBAction func completedItem(_ sender: Any) {
        //注册
        Register()
    }
   
    func Register() {
        SVProgressHUD.show()
        let user = AVObject(className: "ZXUser")
        /// 把文本狂输入的值，设置到对象中
        user.setObject(useTextField.text, forKey: "user")
        user.setObject(passwordTextField.text, forKey: "pass")
        user.setObject(emailTextField.text, forKey: "email")
        user.setObject(locationTextField.text, forKey: "loca")
        user.setObject(questionTextField.text, forKey: "ques")
        user.setObject(answerTextfield.text, forKey: "answ")
        
        
        
        //查询用户名是否被注册
        let query = AVQuery(className: "ZXUser")
        guard let text = useTextField.text else {
            return
        }
        query.whereKey("user", equalTo: text)
        
        // 查询
        query.getFirstObjectInBackground { (object, error) in
            
            SVProgressHUD.dismiss()
            if object != nil {
                SVProgressHUD.showError(withStatus: "用户已经注册")
                self.useTextField.becomeFirstResponder()
                self.completedBTI.isEnabled = false
            }else {
                SVProgressHUD.showSuccess(withStatus: "用户名可用")
                user.saveInBackground({ (success, error) in
                    if success {
                        SVProgressHUD.showSuccess(withStatus: "注册成功")
                        guard let str = self.useTextField.text, let str2 = self.passwordTextField.text else {
                            
                            return
                        }
                        self.hander(str, str2)
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
    //MARK: - 判断是否必填项全部填正确
    
    func isAllCorrect() {
        
        let validator = AJWValidator(type: .string)
        validator?.addValidation(toEnsureMaximumLength: 15, invalidMessage: "最多15字符")
        validator?.addValidation(toEnsureMinimumLength: 3, invalidMessage: "最少3字符")
        useTextField.ajw_attach(validator)
        validator?.validatorStateChangedHandler = {(newState: AJWValidatorState) -> Void in
            
            switch newState {
            case .validationStateValid:
                self.useTextField.highlightState = .Default
                self.possibleInputs.insert(.user)
            default:
                let msg = validator?.errorMessages.first as? String
                self.useTextField.highlightState = UITextBoxHighlightState.Wrong(msg!)
                self.possibleInputs.remove(.user)
            }
            self.completedBTI.isEnabled = self.possibleInputs.isAllOk()
        }
        //密码
        let validator2 = AJWValidator(type: .string)
        validator2?.addValidation(toEnsureMaximumLength: 15, invalidMessage: "最多15位数")
        validator2?.addValidation(toEnsureMinimumLength: 3, invalidMessage: "最少3位数")
        passwordTextField.ajw_attach(validator2)
        validator2?.validatorStateChangedHandler = {(newState: AJWValidatorState) -> Void in
            
            switch newState {
            case .validationStateValid:
                self.passwordTextField.highlightState = .Default
                self.possibleInputs.insert(.pass)
            default:
                let msg = validator2?.errorMessages.first as? String
                self.passwordTextField.highlightState = UITextBoxHighlightState.Wrong(msg!)
                self.possibleInputs.remove(.pass)
            }
            self.completedBTI.isEnabled = self.possibleInputs.isAllOk()
        }
        
        //邮箱
        let validator3 = AJWValidator(type: .string)
        validator3?.addValidationToEnsureValidEmail(withInvalidMessage: "邮箱格式不正确")
        emailTextField.ajw_attach(validator3)
        validator3?.validatorStateChangedHandler = {(newState: AJWValidatorState) -> Void in
            
            switch newState {
            case .validationStateValid:
                self.emailTextField.highlightState = .Default
                self.possibleInputs.insert(.email)
            default:
                let msg = validator3?.errorMessages.first as? String
                self.emailTextField.highlightState = UITextBoxHighlightState.Wrong(msg!)
                self.possibleInputs.remove(.email)
                
            }
            self.completedBTI.isEnabled = self.possibleInputs.isAllOk()
        }
    }
    //MARK: - 检查必填项
    func checkRequeriedField() {
    
        for textField in loginTextfield {
            if (textField.text?.isEmpty)! {
                
               SVProgressHUD.showError(withStatus: "必填选必须完全填完")
//                SVProgressHUD.showInfo(withStatus: "必填选必须完全填完")
//                SVProgressHUD.show(withStatus: "必填选必须完全填完")
//                SVProgressHUD.showProgress(100, status: "必填项必须完全填完")
//                SVProgressHUD.show()
//                SVProgressHUD.popActivity()
//                SVProgressHUD.showProgress(1000)
                
//                SVProgressHUD.setDefaultStyle(.dark)
//                SVProgressHUD.setDefaultAnimationType(.flat)
//                SVProgressHUD.setFadeOutAnimationDuration(0)
//                SVProgressHUD.setBackgroundLayerColor(UIColor.red)
//                 SVProgressHUD.showError(withStatus: "必填选必须完全填完")
                
            }
        }
//        //判断邮箱是否正确
//        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        
//        guard emailPredicate.evaluate(with: emailTextField.text) else {
//            SVProgressHUD.showError(withStatus: "邮箱格式不对")
//            return
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
