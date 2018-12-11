//
//  ExtensionFile.swift
//  LetsNurture
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import CoreData
import SystemConfiguration
import UserNotifications

let IS_IPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
let IS_RETINA = UIScreen.main.scale >= 2.0
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = IS_IPHONE && SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = IS_IPHONE && SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = IS_IPHONE && SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_X = IS_IPHONE && SCREEN_MAX_LENGTH == 812.0


typealias TimerTickClosure = (Timer)->Void
typealias TimerTickBlock = @convention(block) (Timer)->Void
typealias stringBlock = (String)->()
typealias voidBlock = ()->()
typealias objectBlock = (AnyObject?)->()

var SCALE_IPHONE : CGFloat {
    if IS_IPHONE_6P {
        return 1.05
    }
    else if IS_IPHONE_5 || IS_IPHONE_4_OR_LESS {
        return 0.91
    }
    return 1.0
}


// MARK: - getImageWithColor Function -
func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
    let rect  =  CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}

 class Lifted<T> {
    let value: T
    init(_ x: T) {
        value = x
    }
}
func setAssociatedObject<T : UIView>(_ object: AnyObject, value: T, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
    objc_setAssociatedObject(object, associativeKey, value,  policy)
}
func RADIANS(_ degree :Double) -> Double
{
    return ((degree)*Double.pi/180)
}
func getAssociatedObject<T : UIView>(_ object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
    if let v = objc_getAssociatedObject(object, associativeKey) as? T {
        return v
    }
    else if let v = objc_getAssociatedObject(object, associativeKey) as? Lifted<T> {
        return v.value
    }
    else {
        return nil
    }
}
var sharedCache : NSCache<AnyObject, AnyObject> = NSCache()
func degreesToRadians(_ x : Double) -> Float{
    return Float(Double.pi * x / 180.0)
}
func radiandsToDegrees(_ x : Double) -> Float{
    return Float(x * 180.0 / Double.pi)
}
func localNotification(_ fireDate : Date, alertBody  :String, userInfo : [AnyHashable: Any]? = nil) {
    
    if #available(iOS 10.0, *) {
        //iOS 10 or above version
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
//        content.title = ""
        content.body = alertBody
//        content.categoryIdentifier = "alarm"
        content.userInfo = userInfo!
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = Int(fireDate.hour)
        dateComponents.minute = Int(fireDate.minute)
        dateComponents.second = Int(fireDate.second)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    } else {
        // ios 9
        let notification = UILocalNotification()
        notification.fireDate = fireDate
        notification.alertBody = alertBody
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = userInfo
        UIApplication.shared.scheduleLocalNotification(notification)
        
    }
    
    
    
}
