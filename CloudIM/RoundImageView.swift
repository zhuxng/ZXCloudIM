//
//  RongderImageView.swift
//  CloudIM
//
//  Created by 朱星 on 2016/12/24.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

@IBDesignable
class RoundImageView: UIImageView {

   
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = (cornerRadius > 0)
            
        }
    }
    @IBInspectable var  borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var  bordercolor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = bordercolor.cgColor
        }
    }
}
