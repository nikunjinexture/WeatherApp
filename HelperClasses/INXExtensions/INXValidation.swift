//
//  ValidationFile.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import UIKit
func checkInternet() -> Bool
{
    let status = INXReachability().connectionStatus()
    switch status {
    case .unknown, .offline:
        return false
    case .online(.wwan), .online(.wiFi):
        return true
    }
    
}
func jsonStringConvert(_ obj : AnyObject) -> String {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions.prettyPrinted)
        return  String(data: jsonData, encoding: String.Encoding.utf8)! as String
        
    } catch {
        return ""
    }
}
func convertIntoBold(_ boldText : String,normalText : String) -> NSAttributedString
{
    let attributedString = NSMutableAttributedString(string:normalText)
    let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
    let boldString = NSMutableAttributedString(string:boldText, attributes:attrs)
    boldString.append(attributedString)
    return boldString
}
func getDateWithFormate(_ dateStr : String) -> Date
{
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZ"
    let date = df.date(from: dateStr)
    return date!
}
func createProfileUrl(_ id : String) -> String
{
    return "https://graph.facebook.com/\(id)/picture?type=large"
}
func getStringFromDateWithFormate(_ dateStr : Date) -> String
{
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZ"
    let date = df.string(from: dateStr)
    return date
}
func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
    if let data = text.data(using: String.Encoding.utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
        } catch let error as NSError {
            print(error)
        }
    }
    return nil
}
func alertShow(_ controller : UIViewController, title : String = "", message : String = "",okStr : String = "",cancelStr : String = "", okClick : (() -> ())? = nil ) {
    let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    if okStr.length > 0 {
        alert.addAction(UIAlertAction(title: okStr, style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            if let block = okClick {
                block()
            }
        }))
    }
    if cancelStr.length > 0 {
        alert.addAction(UIAlertAction(title: cancelStr.length > 0 ?  cancelStr : "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
    }
    
    controller.present(alert, animated: true, completion: nil)
}
//MARK: Validation Function

func isEmptyString(_ text : String) -> Bool
{
    if text.trim == "" || text.trim.isEmpty
    {
        return true
    }
    else
    {
        return false
    }
    
}
func validateEmailWithString(_ Email: String) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
        return !(regex.firstMatch(in: Email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, Email.count)) != nil)
    } catch {
        return true
    }
}
func validePassword(_ text : NSString) ->Bool
{
    if text.length < 6 || text.length > 16
    {
        return true
    }
    else
    {
        return false
    }
}
func validePhoneNumber(_ text : String)->Bool
{
    if text.count < 8 || text.count > 15
    {
        return true
    }
    else
    {
        return false
    }
}

func valideCardNumber(_ text : NSString)->Bool
{
    if text.length < 16 || text.length > 20
    {
        return true
    }
    else
    {
        return false
    }
}
