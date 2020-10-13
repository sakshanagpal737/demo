 //
//  Common_Methods.swift
//  Bunch
//
//  Created by Manisha on 23/09/16.
//  Copyright © 2016 Manisha. All rights reserved.
//


import UIKit
import Foundation
import SystemConfiguration
import CoreData
import NVActivityIndicatorView
import Reachability

 
class Common_Methods: NSObject
{

    class func validate_Email(email: String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    

  
    
    class func isReachable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
   
    // MARK: - Check String is Null  -----------------
    class func checkStringIsNull(stngVal: AnyObject) -> AnyObject{
       
        if stngVal is String  {
            return stngVal
        }  else if (!stngVal.isEmpty) {
            return stngVal
        }
        else{
            let emptyStrng = ""
            return emptyStrng as AnyObject
        }
    }
    // MARK: - Check Dict Contains Key  -----------------
    class func checkDictContainKey(dict:NSDictionary, key: String) -> Bool{
        if let _ = dict[key]
        {
            return true
        }else{
            return false
        }
    }
    
    
    //MARK: - Alert -----------

  
    
    class func showErrorAlert(error:ErrorMessages){
        let alert = UIAlertController(title: APPNAME, message: error.rawValue, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        rootController.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Show Alert
    class func showAlert(_ msg:String)
    {
        let alert = UIAlertController(title: APPNAME, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        rootController.present(alert, animated: true, completion: nil)
       
    }
    
   
    
    class var rootController:UIViewController
    {
        return (UIApplication.shared.keyWindow?.rootViewController)!
    }
    
   class func initUserDefaults(_ object: Any?, andKey key: String?) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key ?? "")
        defaults.synchronize()
    }
    
    class func saveUDValue(_ value:Any?, key:String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getUDValue(key:String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    class func saveDictInUserDefaults(dict:[String:String], andKey key: String?)
    {
        UserDefaults.standard.set(dict, forKey:key!)
        let result = UserDefaults.standard.value(forKey: key!)
    }
    
   

    // access user defaults with key
   class func accessUserDefaults(withKey key: String?) -> String? {
        let defaults = UserDefaults.standard
        let strValue = defaults.object(forKey: key ?? "") as? String
        return strValue
    }
    
    // access user defaults with key
    class func getDictWithKey(_ key: String?) -> [AnyHashable : Any]? {
        let defaults = UserDefaults.standard
        let dict = defaults.object(forKey: key ?? "") as? [AnyHashable : Any]
        return dict
    }
    
    
    class func getArrayWithKey(_ key: String?) -> [Any]? {
        let defaults = UserDefaults.standard
        let arr = defaults.object(forKey: key ?? "") as? [Any]
        return arr
    }
    
    class func removeUserDefaults(withKey key: String?) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key ?? "")
        defaults.synchronize()
    }
    //remove all Userdefult 
    class func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    class func setTextFieldLook(textField:UITextField){
          textField.layer.borderWidth = 1
          textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
          textField.layer.cornerRadius = 15
          textField.clipsToBounds = true
      }

    class func setTextFieldLook(textFields:[UITextField]){
        for textField in textFields {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
            textField.layer.cornerRadius = 15
            textField.clipsToBounds = true
        }
    }
    
    class func setLeftPadding(textfields: [UITextField]){
        for tf in textfields {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.size.height))
            tf.leftView = view
            tf.leftViewMode = .always
        }
    }


    
    class func showIndicator(view:UIView)
    {
        DispatchQueue.main.async {
            let nv = NVActivityIndicatorView(frame: CGRect(x:view.frame.size.width/2-25,y:view.frame.size.height/2-25,width:50,height:50), type: .ballSpinFadeLoader, color: UIColor.gray, padding: nil)

            nv.tag = 6575
            view.isUserInteractionEnabled = false
            view.addSubview(nv)
            nv.startAnimating()
        }
    }

    class func hideIndicator(view:UIView)
    {
        DispatchQueue.main.async {
            for case let v as NVActivityIndicatorView in view.subviews
            {
                v.stopAnimating()
                if v.tag == 6575
                {
                    v.removeFromSuperview()
                }
            }
            view.isUserInteractionEnabled = true
        }


    }
    
    
    class func returnEmptyLabel() -> UILabel
    {
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height))
            emptyLabel.text = "No Items Found"
        emptyLabel.font = UIFont(name:"SF-Pro-Text-Semibold", size: 25)
            emptyLabel.textAlignment = NSTextAlignment.center
        
        return emptyLabel
    }
    
    
    
    
    
    
    
    class func setTabelBGtext(Ctable:UITableView,status:Bool)
    {
        if status
        {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: Ctable.bounds.size.width, height: Ctable.bounds.size.height))
            
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            Ctable.backgroundView = noDataLabel
        }else{
            Ctable.backgroundView = nil
        }
        Ctable.reloadData()
    }
    

    
    class func returnImageDataFromUrl(urlString:String) -> Data
    {
         let Url = URL(string:urlString)
        let imgData = try? Data(contentsOf: Url!)
        return imgData!
    }
    
    class func getDateWithBaseFormet() -> String
    {
            let dateMaker = DateFormatter()
            dateMaker.dateFormat = "dd:MM:yyyy"
            let startString = dateMaker.string(from:Date())
            return(startString)
    }
    
    static var currentTimestamp: Int {
        return Int(NSDate().timeIntervalSince1970 * 1000)
    }
   
    class func formatDateString(strDate : String, fromFormat : String, toFormat : String) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormatter.dateFormat = fromFormat
        
        let formattedDate = dateFormatter.date(from: strDate)
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        dateFormatter.dateFormat = toFormat
        
        let convertedDate = dateFormatter.string(from: formattedDate!)
        
        return convertedDate
    }
    
    
    
   
}

 @IBDesignable
 open class DesignableImageView: UIImageView {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderColor : UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
 }
 
 @IBDesignable
 open class DesignableButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderColor : UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
 }
 

 @IBDesignable
 open class DesignableTextView: UITextView {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderColor : UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
 }
 
 
 @IBDesignable
 open class DesignableTextField: UITextField {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderColor : UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
 }

