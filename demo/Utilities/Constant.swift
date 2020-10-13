//
//  Constant.swift
//  eLearnEnglish
//
//  Created by Hitesh Grover on 17/12/18.
//  Copyright © 2018 Hitesh Grover. All rights reserved.
//

import UIKit

let APPNAME = "Demo"
var appstoreLink = "" // apple app store link
var DEVICE_TOKEN = ""




struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
}

public enum Storyboards:String {
    case main = "Main"
}

public enum Device {
    case iPhone5 , iPhone6, iPhonePlus, iPhoneX, iPhoneXSMax, iPhoneXS, iPhoneXR
}

struct Placeholders {
}




var kBaseUrl = "http://phpstack-473415-1486295.cloudwaysapps.com/api/"





struct UserDefaultKeys { // NSUserDefault Keys
    static let userid = "userid"
    static let kIsLogin = "isLogin"
    static let kToken = "token"
    static let kIsNewUser = "isNewUser"
     static let kUserName = "username"
     static let kUserPhone = "phone"
     static let kUserEmail = "email"
    static let kUserAddress = "address"
    static let kLoginPlatform   = "loginthrough"
    static let kUserImage   = "userImage"
    static let kCartCount = "cartCount"
    static let kUserPackage = "userPackage"
   static let kUserCity   = "city"
    static let kUserState = "state"
    static let kUserZipCode = "zipcode"
    static let kApiToken  = "apiToken"
    
}


public enum ErrorMessages:String
{
    case networkError = "We are having trouble with our server right now, Please try again after some time."
    case noConnection = "It seems you are not connected to the internet!"
    case commonError = "Something went wrong!\nPlease try again."
    case requiredFields = "Please fill all required fields"
    case imageUploadError = "Failed to upload image"
    case validEmail = "Please enter a valid email address"
    case validPhone = "Please enter a valid phone number"
    case dataNotSaved = "Could not save data! Please try again"
    case imageUploading = "Please wait! Image is being uploaded"
    case userNotCreated = "Failed to register, please retry!"
    case noAudio = "No audio added"
    case noEvents = "No Events added"
    case noModules = "No Modules added"
    case noUsername = "Please enter a valid username"
    case noPassword = "Please enter a valid password.It must have a mimimum of 8 characters."
    case passwordDontMatch = "Password do not match confirm password"
    case sessionExpired = "Session Expired.Please login again."
    
}
