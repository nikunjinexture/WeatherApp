//
//  UIViewController+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Toaster

// MARK: - UIViewController Extension -
extension UIViewController {
    
    func getPdfThumb(url:NSURL, pageBase1:Int) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let firstPage = document.page(at: pageBase1) else { return nil }
        
        let width:CGFloat = 240.0;
        
        var pageRect:CGRect = firstPage.getBoxRect(.mediaBox)
        let pdfScale:CGFloat = width/pageRect.size.width
        pageRect.size = CGSize(width: pageRect.size.width*pdfScale, height: pageRect.size.height*pdfScale)
        pageRect.origin = CGPoint.zero
        
        UIGraphicsBeginImageContext(pageRect.size)
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        // White background
        context.setFillColor(red: 1.0,green: 1.0,blue: 1.0,alpha: 1.0)
        context.fill(pageRect)
        
        context.saveGState()
        
        // Handle rotation
        context.translateBy(x: 0.0, y: pageRect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.concatenate(firstPage.getDrawingTransform(.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true))
        
        context.drawPDFPage(firstPage)
        context.restoreGState()
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        return image
    }
    
    func addAnimation(nav:UINavigationController)  {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        nav.view.layer.add(transition, forKey: nil)
    }
    func simpleAlert(_ message:String?)  {
        let alertController = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func atdAlert(_ message:String,number:String,okClick : (() -> ())? = nil)  {
        let alertController = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
            if let block = okClick {
                block()
            }
        }))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let messageText = NSMutableAttributedString(
            string: message + "\n" + number,
            attributes: [
                NSAttributedStringKey.paragraphStyle: paragraphStyle,
                NSAttributedStringKey.font : UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote),
                NSAttributedStringKey.foregroundColor : UIColor.black
            ]
        )
        let range = NSRange(location: message.length+1, length: number.length)
        messageText.addAttribute(NSAttributedStringKey.font, value: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline), range: range)
        alertController.setValue(messageText, forKey: "attributedMessage")
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showToaster(message:String)  {
        ToastView.appearance().backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "loginBk"))
        ToastView.appearance().font = UIFont(name: "Poppins-Medium", size: 14)!
        ToastView.appearance().textColor = .white
        ToastView.appearance().cornerRadius = 2
        ToastView.appearance().bottomOffsetPortrait = UIScreen.main.bounds.size.height - (IS_IPHONE_X ?125:100)
        let tost = Toast(text: message, duration: 0.50)
        
        tost.show()
    }
    
    func showHud(message:String)  {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setFont(UIFont(name: "Poppins-Medium", size: 14)!)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(UIColor(patternImage: #imageLiteral(resourceName: "loginBk")))
        
        SVProgressHUD.show(withStatus: message)
    }
    func hideHud()  {
        SVProgressHUD.dismiss()
    }
    
    func handleError(error:Error) -> Bool {
        if (error as NSError).code == -1005 { // cocnnection was lost
            return true
        }
        else if (error as NSError).code == -1001 { // Request time out
            return true
        }
        else {
            return false
        }
    }
    func dayName(index: UInt) -> String {
        switch index {
        case 1:
            return WeekDay.Sunday.rawValue
        case 2:
            return WeekDay.Monday.rawValue
        case 3:
            return WeekDay.Tuesday.rawValue
        case 4:
            return WeekDay.Wednseday.rawValue
        case 5:
            return WeekDay.Thursday.rawValue
        case 6:
            return WeekDay.Friday.rawValue
        case 7:
            return WeekDay.Saturday.rawValue
        default:
            return ""
        }
    }
    func printImage(image:NSData)  {
        
        let path = NSTemporaryDirectory() + "HelaPay.pdf"
        if FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.removeItem(atPath: path)
        }
        
        if image.write(toFile: path, atomically: true) {
            
            let sharedObjects = [URL(fileURLWithPath: path)] as [Any]
            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            
            DispatchQueue.main.async {
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    func shareURL(url:String)  {
        let sharedObjects = [URL(string: url)!] as [Any]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    func printImage(url:URL,frame:CGRect)  {
        
        let sharedObjects = [url] as [Any]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.popoverPresentationController?.sourceRect = frame
        activityViewController.popoverPresentationController?.permittedArrowDirections = .any
        
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func getCountryCallingCode(countryRegionCode:String)->String{
        
        let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
        let countryDialingCode = prefixCodes[countryRegionCode]
        return countryDialingCode!
    }
}


extension UITableView {
    func setContentInsetToBottom() {
        let numRows = self.numberOfRows(inSection: 0)
        var contentInsetTop = self.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
        }
        self.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0)
        
    }
}
