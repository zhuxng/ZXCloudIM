//
//  Print.swift
//  GCD
//
//  Created by 朱星 on 2016/11/4.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit


func ZXLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber:Int = #line)
{
    //    print("\(fileName as NSString))\n\(methodName)\n lineNumber:\(lineNumber)\nmessage:\(message)")
    #if DEBUG
        print("在\(methodName)方法中的[第\(lineNumber)行]打印信息:\(message)")
    #endif
}
