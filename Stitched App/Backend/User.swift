//
//  User.swift
//  Stitched App
//
//  Created by Com on 16/01/2017.
//  Copyright © 2017 Com. All rights reserved.
//

import UIKit


enum Role: String {
	case client = "client"
	case vendor = "vendor"
}


struct User {
	
	var id: String!
	var avatar: String!
	var name: String!
	var email: String!
	var phoneNumber: String!
	var role: String!
	var ranking: String!
	var follower: Int
	var network: Int
	
	init () {
		self.id = ""
		self.avatar = ""
		self.name = ""
		self.email = ""
		self.phoneNumber = ""
		self.role = ""
		self.ranking = "0"
		self.follower = 0
		self.network = 0
	}
	
	mutating func restoreUser() {
		if let userData = UserDefaults.standard.value(forKey: "user_data") as! [String : String]! {
			self.id = userData["id"]
			self.avatar = userData["avatar"]
			self.name = userData["name"]
			self.email = userData["email"]
			self.phoneNumber = userData["phoneNumber"]
			self.role = userData["role"]
			self.ranking = userData["ranking"]
			self.follower = Int(userData["follower"]!)!
			self.network = Int(userData["network"]!)!
		}
	}
	
	func saveUser() {
		var userData = [String: String]()
		
		userData.updateValue(self.id ?? "", forKey: "id")
		userData.updateValue(self.avatar ?? "", forKey: "avatar")
		userData.updateValue(self.name ?? "", forKey: "name")
		userData.updateValue(self.email ?? "", forKey: "email")
		userData.updateValue(self.phoneNumber ?? "", forKey: "phoneNumber")
		userData.updateValue(self.role ?? "", forKey: "role")
		userData.updateValue(self.ranking ?? "", forKey: "ranking")
		userData.updateValue("\(self.follower)", forKey: "follower")
		userData.updateValue("\(self.network)", forKey: "network")
		
		UserDefaults.standard.setValue(userData, forKey: "user_data")
		UserDefaults.standard.synchronize()
	}
	
	static func getUser(fromID userID: String!, complete: @escaping (_ user: User?) -> Swift.Void) {
		var mySelf = User()
		
		Reference.FBRef.allUsers.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
			let userData = snapshot.value as! [String: Any]!
			
			mySelf.id = userID
			mySelf.email = userData?["email"] as! String!
			mySelf.name = userData?["name"] as! String!
			mySelf.avatar = userData?["avatar_image"] as! String!
			mySelf.phoneNumber = userData?["phone"] as! String!
			mySelf.role = userData?["role"] as! String!
			
			mySelf.ranking = (userData?["ranking"] != nil ? userData?["ranking"] as! String! : "0")
			mySelf.follower = (userData?["follower"] != nil ? Int(userData?["follower"] as! String!)! : 0)
			mySelf.network = (userData?["network"] != nil ? Int(userData?["network"] as! String!)! : 0)
			
			complete(mySelf)
		})
	}
}

var currentUser = User()
