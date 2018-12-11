//
//  UIImage+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIImage Extension -
extension UIImage {
    
    var base64String : String {
        let imageData = UIImageJPEGRepresentation(self, 1.0)
        return imageData?.base64EncodedString() ?? ""
    }
    var JPEGRepresentation:Data {
        return UIImageJPEGRepresentation(self, 1.0)!
    }
    var PNGRepresentation:Data {
        return UIImagePNGRepresentation(self)!
    }
    
    func createPDF() -> NSData? {
        
        let pdfData = NSMutableData()
        let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!
        
        var mediaBox = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(self.cgImage!, in: mediaBox)
        pdfContext.endPage()
        
        return pdfData
    }
    
    func createPDF(image:UIImage) -> NSData? {
        
        let pdfData = NSMutableData()
        let image1Rect = CGRect(x: 20, y: 20, width: self.size.width-40, height: self.size.height)
        let image2Rect = CGRect(x: 20, y: self.size.height+40, width: image.size.width-40, height: image.size.height)
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: image.size.height+self.size.height+60)
        
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()
        context?.draw(self.imageRotatedByDegrees(180, flip: true).cgImage!, in: image1Rect)
        context?.draw(image.imageRotatedByDegrees(180, flip: true).cgImage!, in: image2Rect)
        UIGraphicsEndPDFContext()
        
        return pdfData
    }
    
    func getPixelColor(_ pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    var normalizedImage : UIImage {
        return UIImage(cgImage: self.cgImage!, scale: self.scale, orientation: .up)
    }
    func imageRotatedByDegrees(_ degrees: CGFloat, flip: Bool) -> UIImage {
//        let radiansToDegrees: (CGFloat) -> CGFloat = {
//            return $0 * (180.0 / CGFloat(M_PI))
//        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        bitmap!.rotate(by: degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap!.scaleBy(x: yFlip, y: -1.0)
        bitmap?.draw( cgImage!, in: CGRect (x: -size.width / 2,y: -size.height / 2,width: size.width,height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    var fixrotation : UIImage {
        if imageOrientation == .up {
            return self
        }
        var transform: CGAffineTransform = .identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -CGFloat(Double.pi / 2))
        case .up, .upMirrored:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage!.bitsPerComponent, bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: UInt32(cgImage!.bitmapInfo.rawValue))!
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx.draw(cgImage!, in: CGRect(x: 0,y: 0,width: size.height,height: size.width))
        default:
            ctx.draw(cgImage!, in: CGRect(x: 0,y: 0,width: size.width,height: size.height))
        }
        let cgimg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgimg)
        return img
    }
}
