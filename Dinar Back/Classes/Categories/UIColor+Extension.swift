//
//  UIColor+Extension.swift
//  Dinar Back
//
//  Created by Madhup Yadav on 22/07/17.
//  Copyright © 2017 Jixtra Technologies LLP. All rights reserved.
//

import UIKit

extension UIColor{
    
    static func appGreenColor() -> UIColor {
//        return UIColor(red: 176.0/255.0, green: 11.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        return UIColor(red: 82.0/255.0, green: 160.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    }
    
    static func appGrayColor() -> UIColor {
        return UIColor(red: 236.0/255.0, green: 237.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    }
    
    static func buttonDisabledBackgroundColor() -> UIColor {
        return UIColor(red: 176.0/255.0, green: 11.0/255.0, blue: 55.0/255.0, alpha: 1.0)
    }
    
    static func buttonDisabledTitleColor() -> UIColor {
        return UIColor(red: 200.0/255.0, green: 201.0/255.0, blue: 203.0/255.0, alpha: 1.0)
    }
    
    static func buttonEnabledBackgroundColor() -> UIColor {
        return UIColor.appGreenColor()
    }
    
    static func buttonEnabledTitleColor() -> UIColor {
        return UIColor.white
    }
    
    static func titleGrayColor() -> UIColor {
        return UIColor(red: 130.0/255.0, green: 130.0/255.0, blue: 130.0/255.0, alpha: 1.0)
    }
    
    static func cellTitleLabelGrayColor() -> UIColor {
        return UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    }
    
    static func titleRedColor() -> UIColor {
        return UIColor(red: 217.0/255.0, green: 130.0/255.0, blue: 143.0/255.0, alpha: 1.0)
    }
    
    static func separatorGrayColor() -> UIColor {
        return UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
    }
    
    static func separatorRedColor() -> UIColor {
        return UIColor.titleRedColor()
    }
    
}
