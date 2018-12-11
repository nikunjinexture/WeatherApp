//
//  UIScreen+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen {
    
    class var size: CGSize {
        return UIScreen.main.bounds.size
    }
    
    class var width: CGFloat {
        return size.width
    }
    
    class var height: CGFloat {
        return size.height
    }
}
