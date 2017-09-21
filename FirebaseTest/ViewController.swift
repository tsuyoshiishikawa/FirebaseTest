//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Tsuyoshi Ishikawa on 2017/09/20.
//  Copyright © 2017年 Tsuyoshi Ishikawa. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

	@IBOutlet weak var phoneNum: UITextField!
	@IBOutlet weak var sendCode: UIButton!
	@IBOutlet weak var logout: UIButton!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		
		if(Auth.auth().currentUser?.phoneNumber == nil){
			logout.isEnabled = false
		}else{
			sendCode.isEnabled = false
		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func sendCode(_ sender: Any) {
		let alert = UIAlertController(title: "Phone number", message: "Is this your phone number?\n\(phoneNum.text!)", preferredStyle: .alert)
		let action = UIAlertAction(title: "Yes", style: .default, handler:{ (UIAlertAction) -> Void in
			PhoneAuthProvider.provider().verifyPhoneNumber(self.phoneNum.text!) { (verificationID, error) in
				if let error = error {
					print(error.localizedDescription)
				}else{
					// Sign in using the verificationID and the code sent to the user
					let defaults = UserDefaults.standard
					defaults.set(verificationID, forKey: "authVerificationID")
					self.performSegue(withIdentifier: "code", sender: Any?.self)
				}
			}
		})
		let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)

		alert.addAction(action)
		alert.addAction(cancel)
		self.present(alert, animated: true, completion: nil)
		
	}
	@IBAction func logout(_ sender: Any) {
		let userInfo = Auth.auth().currentUser?.providerData[0]
		let providerID = userInfo?.providerID
		print("providerID = \(providerID!)")
		
		//電話番号だけログアウト
		Auth.auth().currentUser?.unlink(fromProvider: providerID!, completion: { (user, error) in
			
			if let error = error {
				print(error.localizedDescription)
			}else{
				print("Success unlink!")
				self.sendCode.isEnabled = true
				self.viewDidLoad()
			}
			
		})
	}

}

