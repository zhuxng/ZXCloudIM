//
//  User.swift
//  CloudIM
//
//  Created by 朱星 on 2016/12/27.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class User: NSObject {
    var userName: String?
    var passWord: String?
    init(userName: String, passWord: String) {
        self.userName = userName
        self.passWord = passWord
    }
}
