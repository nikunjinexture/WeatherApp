//
//  Extensions.swift
//  ProjectStucture
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    var length:Int {
        return self.count
    }
    
    


    var isValidEmail:Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidUserName: Bool{
        //let regex =  "^[a-z]([a-z0-9]*[-_][a-z0-9][a-z0-9]*)$"
        let regex = "/^[a-zA-Z ]*$/"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordTest.evaluate(with: self)
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var intValue: Int32 {
        return (self as NSString).intValue
    }
    var integerValue: Int {
        return (self as NSString).integerValue
    }
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    var longLongValue: Int64 {
        return (self as NSString).longLongValue
    }
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func getDate(formate:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate //this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let date = dateFormatter.date(from: self)

        return date!
    }
}
extension Int {
    var toString: String {
        return String(self)
    }
}

extension Double {
    var toString: String {
        return String(self)
    }
}

extension Float {
    var toString: String {
        return String(self)
    }
}

extension Int32 {
    var toString: String {
        return String(self)
    }
}

extension Int64 {
    var toString: String {
        return String(self)
    }
}

extension Bool {
    var toString: String {
        return self.description
    }
    var toInt: Int {
        return NSNumber(value: self).intValue
    }
}

extension UIColor{
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}
extension UITextField {
    var isEmptyText:Bool! {
        return !(self.text!.length > 0)
    }
}
extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
//        mask.shadowColor = UIColor.white.cgColor
//        mask.shadowOffset = CGSize(width: 0, height: 0)
//        mask.shadowRadius = 50
//        mask.shadowOpacity = 1
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
extension NSObject {
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    func isAllowFilterReset(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

extension Data {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print(error)
        }
        return nil
    }
}
extension String {
    var data: Data {
        return self.data(using: String.Encoding.utf8)!
    }
}

extension UIDevice{
    var isiPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    var isiPad: Bool {
        return UIDevice().userInterfaceIdiom == .pad
    }
    
    var isiPhone4: Bool {
        return UIScreen.main.nativeBounds.height == 960
    }
    
    var isiPhone5: Bool {
        return UIScreen.main.nativeBounds.height == 1136
    }
    
    var isiPhone6: Bool {
        return UIScreen.main.nativeBounds.height == 1334
    }
    
    var isiPhone6Plus: Bool {
        return UIScreen.main.nativeBounds.height == 2208
    }
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}


extension UICollectionView {
    func takeWholeScreenshot() -> UIImage {
        
        self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        
        UIGraphicsBeginImageContext(self.contentSize)
        
        if let aContext = UIGraphicsGetCurrentContext() {
            self.layer.render(in: aContext)
        }
        let rows: Int = self.numberOfItems(inSection: 0)
        
        for i in 0..<rows {
            self.scrollToItem(at: IndexPath(item: i, section: 0), at: .top, animated: false)
            
            if let aContext = UIGraphicsGetCurrentContext() {
                self.layer.render(in: aContext)
            }
        }
        self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        return image!
    }
    
    func takeWholeWithoutNotiScreenshot() -> UIImage {
        
        self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        
        UIGraphicsBeginImageContext(self.contentSize)
        
        if let aContext = UIGraphicsGetCurrentContext() {
            self.layer.render(in: aContext)
        }
        let rows: Int = self.numberOfItems(inSection: 0)
        
        for i in 0..<(rows-3) {
            self.scrollToItem(at: IndexPath(item: i, section: 0), at: .top, animated: false)
            
            if let aContext = UIGraphicsGetCurrentContext() {
                self.layer.render(in: aContext)
            }
        }
        self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        return image!
    }
}


class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}
