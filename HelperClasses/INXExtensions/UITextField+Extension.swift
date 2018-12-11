//
//  UITestField+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//


import UIKit
import Foundation


extension UITextField {
    func errorMessageView() -> LNErrorMessageView? {
        return (self.rightView is LNErrorMessageView) ? (self.rightView as! LNErrorMessageView) : nil
    }
    
    func setupErrorMessageView() {
        self.rightView = LNErrorMessageView.errorMessageView()
    }
    func setupErrorMessageViewWithImage(_ img : UIImage) {
        self.rightView = LNErrorMessageView.errorMessageView(img)
    }
    
    func setupErrorMessageViewWithView(_ errorMessageView: LNErrorMessageView) {
        self.rightView = errorMessageView
    }
    
    func showError() {
        self.rightViewMode = .always
    }
    
    func hideError() {
        self.rightViewMode = .never
    }
    var checkEmoji: Bool{
        if (self.textInputMode?.primaryLanguage == "emoji") || !((self.textInputMode?.primaryLanguage) != nil) {
            return false
        }else{
            return true
        }
    }
}
class LNErrorMessageView : UIImageView {
    class func errorMessageView() -> LNErrorMessageView {
        let errorIconView: LNErrorMessageView = LNErrorMessageView()
        let bundle : Bundle = Bundle(for: LNErrorMessageView.self)
        let url: URL = (bundle.url(forResource: "LetsPod", withExtension: "bundle")! as NSURL) as URL
        let imageBundle: Bundle = Bundle(url: url as URL)!
        var errorIconImage: UIImage = UIImage(contentsOfFile: imageBundle.path(forResource: "errorIcon", ofType: "png")!)!
        errorIconImage = errorIconImage.withRenderingMode(.alwaysTemplate)
        errorIconView.image = errorIconImage
        return errorIconView
    }
    class func errorMessageView(_ img : UIImage) -> LNErrorMessageView {
        let errorIconView: LNErrorMessageView = LNErrorMessageView(image:img )
        return errorIconView
    }
}
