//
//  NSAttributedString+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    class func HTMLString(_ HTMLString: String) throws -> NSAttributedString?{
        let data = HTMLString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        do {
            return try NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                 .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch  {
            NSException(name: NSExceptionName(rawValue: "Html"), reason: "Not convert", userInfo: nil).raise()
        }
        return nil
    }
    class func attributedString(_ string: String, withFont font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
