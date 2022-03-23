//
//  Extensions.swift
//  TestProject
//
//  Created by Jignesh's Mac on 26/06/21.
//

import Foundation
import UIKit
import SDWebImage

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat = 20) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}

extension UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func cornerRadius(cornerRadius: CGFloat = 5) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func setupCardView(radius: CGFloat = 10.0) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
    }
}

extension UIColor {
    
    func hexStringToUIColor (hex:String, alpha: CGFloat = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UITableView {
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        let viewCenter = convert(center, from: view.superview)
        let indexPath = indexPathForRow(at: viewCenter)
        return indexPath
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension String {
    func toUrl() -> URL {
        return URL(string: self)!
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

struct RuntimeError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}

extension UIViewController {
    
    func showAlert(_ message:String, buttons:[String], completion:((_ tappedIndex: Int) -> Void)!) -> Void {
      
      let alertController = UIAlertController(title: Bundle.appName(), message: message, preferredStyle: .alert)
      alertController.setValue(NSAttributedString(string: Bundle.appName(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0), NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
      
      alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.foregroundColor : UIColor.darkGray]), forKey: "attributedMessage")
      
      for index in 0..<buttons.count {
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
          (alert: UIAlertAction!) in
          if(completion != nil){
            completion(index)
          }
        })
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
      }
        if let viewcontrooler = UIApplication.shared.delegate?.window??.rootViewController
        {
            viewcontrooler.present(alertController, animated: true, completion:nil)
        }
        else
        {
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    public func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style, alertActions: [UIAlertAction]) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
      
      for alertAction in alertActions {
        alertController.addAction(alertAction)
      }
      
      self.present(alertController, animated: true, completion: nil)
    }
}

extension Bundle {
  static func appName() -> String {
    guard let dictionary = Bundle.main.infoDictionary else {
      return ""
    }
    if let appName : String = dictionary["CFBundleName"] as? String {
      return appName
    } else {
      return ""
    }
  }
}

extension UIImageView {
  
  func setImage(imageUrl: URL) {
    sd_imageIndicator = SDWebImageActivityIndicator.gray
    sd_setImage(with: imageUrl, placeholderImage: nil, options: .queryDiskDataSync)
  }
  
  func setImage(imageUrl: URL, imageThumbUrl: URL) {
    setImage(imageUrl: imageThumbUrl)
    SDWebImageManager.shared.loadImage(with: imageUrl, options: .continueInBackground, progress: nil, completed: { (downloadedImage, data, error, cacheType, true, imageUrl) in
      if downloadedImage != nil {
        self.image = downloadedImage
      }
    })
  }
}
