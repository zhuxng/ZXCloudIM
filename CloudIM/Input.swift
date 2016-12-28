//
//  Input.swift
//  CloudIM
//
//  Created by 朱星 on 2016/12/26.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import Foundation

struct ZXInputs: OptionSet {
    let rawValue: Int
    static let user = ZXInputs(rawValue: 1 << 0)
    static let pass = ZXInputs(rawValue: 1 << 1)
    static let email = ZXInputs(rawValue: 1 << 2)
    
}
//判断是否全部输入
extension ZXInputs {
    
    
    func isAllOk() -> Bool {
//        return self == [.user, .pass, .email]
//        return self.rawValue == 0b111
        let counts = 3
        var found = 0
        
        for time in 0..<counts {
            
            if self.contains(ZXInputs(rawValue: 1 << time)) {
                found += 1
            }
        }
        return found == counts
    }
    
}

		
