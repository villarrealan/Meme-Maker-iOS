//
//  SettingsManager.swift
//  Meme Maker
//
//  Created by Avikant Saini on 4/5/16.
//  Copyright © 2016 avikantz. All rights reserved.
//

import UIKit
import SVProgressHUD
import ChameleonFramework
import IQKeyboardManagerSwift

let kSettingsTimesLaunched			= "kTimesLaunched"
let kSettingsContinuousEditing		= "kContinuousEditing"
let kSettingsAutoDismiss			= "kAutoDismiss"
let kSettingsUploadMemes			= "kEnableMemeUpload"
let kSettingsResetSettingsOnLaunch	= "kResetSettingsOnLaunch"
let kSettingsDarkMode				= "kDarkMode"
let kSettingsViewModeIsList			= "kMemeListViewModeIsList"
let kSettingsLastSortKey			= "kLastSortOrderKey"
let kSettingsNumberOfElementsInGrid	= "kNumberOfElementsInGrid"

var globalBackColor: UIColor = UIColor(hexString: "EFF0EF")
var globalTintColor: UIColor = UIColor(hexString: "326400")

func updateGlobalTheme () -> Void {
	if isDarkMode() {
		globalBackColor = UIColor(white: 0.12, alpha: 1)
		globalTintColor = UIColor(hexString: "AAFA78")
		UIApplication.sharedApplication().statusBarStyle = .LightContent
		IQKeyboardManager.sharedManager().keyboardAppearance = .Dark
	}
	else {
		globalBackColor = UIColor(hexString: "EFF0EF")
		globalTintColor = UIColor(hexString: "326400")
		UIApplication.sharedApplication().statusBarStyle = .Default
		IQKeyboardManager.sharedManager().keyboardAppearance = .Light
	}
	
	UINavigationBar.appearance().backgroundColor = globalBackColor
	UINavigationBar.appearance().tintColor = globalTintColor
	UINavigationBar.appearance().barTintColor = globalBackColor
	
	UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "EtelkaNarrowTextPro", size: 18)!, NSForegroundColorAttributeName: globalTintColor]
	
	UITabBar.appearance().backgroundColor = globalBackColor
	UITabBar.appearance().tintColor = globalTintColor
	UITabBar.appearance().barTintColor = globalBackColor
	
	UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "EtelkaNarrowTextPro", size: 13)!, NSForegroundColorAttributeName: globalTintColor], forState: .Selected)
	UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "EtelkaNarrowTextPro", size: 13)!, NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
	
	UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "EtelkaNarrowTextPro", size: 16)!, NSForegroundColorAttributeName: globalTintColor], forState: .Normal)
	
	UITableView.appearance().backgroundColor = globalBackColor
	UITableView.appearance().tintColor = globalTintColor
	
	UICollectionView.appearance().backgroundColor = globalBackColor
	UICollectionView.appearance().tintColor = globalTintColor
	
	UIButton.appearance().tintColor = globalTintColor
	
	UISwitch.appearance().tintColor = globalTintColor
	UISwitch.appearance().onTintColor = globalTintColor
	
	UISearchBar.appearance().backgroundColor = globalBackColor
	UISearchBar.appearance().tintColor = globalTintColor
	UISearchBar.appearance().barTintColor = globalBackColor
	
	UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).defaultTextAttributes = [NSFontAttributeName: UIFont(name: "EtelkaNarrowTextPro", size: 14)!, NSForegroundColorAttributeName: globalTintColor]
	UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).defaultTextAttributes = [NSFontAttributeName: UIFont(name: "EtelkaNarrowTextPro", size: 14)!, NSForegroundColorAttributeName: globalTintColor.colorWithAlphaComponent(0.8)]
	
	SVProgressHUD.setFont(UIFont(name: "EtelkaNarrowTextPro", size: 16))
	SVProgressHUD.setBackgroundColor(globalBackColor)
	SVProgressHUD.setForegroundColor(globalTintColor)
}

func isDarkMode() -> Bool {
	return SettingsManager.sharedManager().getBool(kSettingsDarkMode)
}

class SettingsManager: NSObject {

	// MARK:- Shared Instance
	
	private static let sharedInstance = SettingsManager()
	
	private let defaults = NSUserDefaults.standardUserDefaults()
	
	class func sharedManager () -> SettingsManager {
		return sharedInstance
	}
	
	// MARK:- Save and fetch stuff
	
	func setObject(object: AnyObject, key: String) {
		defaults.setObject(object, forKey: key)
	}
	
	func getObject(key: String) -> AnyObject? {
		return defaults.objectForKey(key)
	}
	
	func setBool(bool: Bool, key: String) {
		defaults.setBool(bool, forKey: key)
	}
	
	func getBool(key: String) -> Bool {
		return defaults.boolForKey(key)
	}
	
	func setInteger(value: Int, key: String) {
		defaults.setInteger(value, forKey: key)
	}
	
	func getInteger(key: String) -> Int {
		return defaults.integerForKey(key)
	}
	
	func setFloat(value: Float, key: String) {
		defaults.setFloat(value, forKey: key)
	}
	
	func getFloat(key: String) -> Float {
		return defaults.floatForKey(key)
	}
	
	func deleteObject(key: String) {
		defaults.removeObjectForKey(key)
	}
	
	func saveLastUpdateDate() -> Void {
		let formatter = NSDateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let date = formatter.stringFromDate(NSDate())
		defaults.setObject(date, forKey: "lastUpdateDate")
	}
	
	func getLastUpdateDate() -> NSDate {
		if (defaults.objectForKey("lastUpdateDate") != nil) {
			let dateString = "\(defaults.objectForKey("lastUpdateDate") as! String)"
			let formatter = NSDateFormatter()
			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
			let date = formatter.dateFromString(dateString)
			return date!
		}
		return NSDate(timeIntervalSinceNow: (-10 * 86400))
	}
	
}
