//
//  String+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import UIKit

// MARK: - String Extension -
extension String {
    
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    var isBlank :Bool {
        if self == nil {
            return true
        }
        return self.length > 0
    }
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self as String, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    func isStringLink() -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.count > 0) else { return false }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) > 0 {
            return true
        }
        return false
    }
    
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        // Use NumberFormatter to check if we can turn the string into a number
        // and to get the locale specific decimal separator.
        let formatter = NumberFormatter()
        formatter.allowsFloats = true // Default is true, be explicit anyways
        let decimalSeparator = formatter.decimalSeparator ?? "."  // Gets the locale specific decimal separator. If for some reason there is none we assume "." is used as separator.
        
        // Check if we can create a valid number. (The formatter creates a NSNumber, but
        // every NSNumber is a valid double, so we're good!)
        if formatter.number(from: self) != nil {
            // Split our string at the decimal separator
            let split = self.components(separatedBy: decimalSeparator)
            
            // Depending on whether there was a decimalSeparator we may have one
            // or two parts now. If it is two then the second part is the one after
            // the separator, aka the digits we care about.
            // If there was no separator then the user hasn't entered a decimal
            // number yet and we treat the string as empty, succeeding the check
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            // Finally check if we're <= the allowed digits
            return digits.characters.count <= maxDecimalPlaces    // TODO: Swift 4.0 replace with digits.count, YAY!
        }
        
        return false // couldn't turn string into a valid number
    }
    
    var isBackSpace : Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            return true
        }
        
        return false
    }
    var isAlphaWithSpace : Bool {
        let alphaNumericRegex = "[A-Za-z](?:[a-zA-Z]|[ ](?![ ]))*"
        let text = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegex)
        guard text.evaluate(with: self) else { return false }
        return true
    }
    
    var isCharacterWithSpace: Bool{
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z\\s]+", options: [])
        let range = regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range.length == self.count
    }
    
    var isCharacterNumberWithSpace: Bool{
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z0-9\\s]+", options: [])
        let range = regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range.length == self.count
    }
    var isNumberWithSlash : Bool{
        let regex = try! NSRegularExpression(pattern: "[0-9/\\s-]*", options: [])
        let range = regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range.length == self.count
    }
    var isCountryCode : Bool{
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z0-9+\\s-]*", options: [])
        let range = regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range.length == self.count
    }
    
    var isUsernameString : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz._1234567890").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    var isEmailString : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz._1234567890@").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    var isCharacter : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    var isNumber : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "1234567890").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    var isNumberWithPoint : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "1234567890.").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    func widhtOfString (_ font : UIFont,height : CGFloat) -> CGFloat {
        let attributes = [NSAttributedStringKey.font:font]
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude,height: height),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: attributes, context: nil)
        return  rect.size.width
    }
    func millisecondToDateString(_ formate : String) -> String {
        return millisecondToDate.toString(formate)!
    }
    var millisecondToDate : Date {
        return Date(timeIntervalSince1970: Double(self) != nil ? Double(self)!  / 1000: 0)
    }
    func intervalToDateString(_ formate : String) -> String {
        return intervalToDate.toString(formate)!
    }
    var intervalToDate : Date {
        return Date(timeIntervalSince1970: Double(self) != nil ? Double(self)! : 0)
    }
    func toDate( _ format:String) -> Date? {
        let formatter:DateFormatter = DateFormatter()
//        formatter.locale = Locale(identifier: "UTC")
        formatter.timeZone =  TimeZone.ReferenceType.local
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    func toLongDate() -> Date? {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        return formatter.date(from: self)
    }
    var trim : String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var ns: NSString {
        return self as NSString
    }
    var pathExtension: String? {
        return ns.pathExtension
    }
    var lastPathComponent: String? {
        return ns.lastPathComponent
    }
    
    func contains(string s: String) -> Bool
    {
        return self.range(of: s) != nil ? true : false
    }
    
    func isMatch(_ regex: String, options: NSRegularExpression.Options) -> Bool
    {
        do {
            let exp = try NSRegularExpression(pattern: regex, options: options)
            let matchCount = exp.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.length))
            return matchCount > 0
        }
        catch {
            return false
        }
        
    }
    func getMatches(_ regex: String, options: NSRegularExpression.Options) -> [NSTextCheckingResult]
    {
        do {
            let exp = try NSRegularExpression(pattern: regex, options: options)
            let matches = exp.matches(in: self, options: [], range: NSMakeRange(0, self.length))
            return matches as [NSTextCheckingResult]
        }
        catch {
            return [NSTextCheckingResult]()
        }
        
    }
}
extension NSString {
    var trim : NSString {
        return self.trimmingCharacters(in: CharacterSet.whitespaces) as NSString
    }
}
extension String.Index{
    func successor(in string:String)->String.Index{
        return string.index(after: self)
    }
    
    func predecessor(in string:String)->String.Index{
        return string.index(before: self)
    }
    
    func advance(_ offset:Int,for string:String)->String.Index{
        return string.index(self, offsetBy: offset)
    }
}

