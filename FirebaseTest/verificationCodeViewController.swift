//
//  verificationCodeViewController.swift
//  FirebaseTest
//
//  Created by Tsuyoshi Ishikawa on 2017/09/20.
//  Copyright © 2017年 Tsuyoshi Ishikawa. All rights reserved.
//

import UIKit
import Firebase

class verificationCodeViewController: UIViewController {

	@IBOutlet weak var code: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func login(_ sender: Any) {
		let defaults = UserDefaults.standard
		let credential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVerificationID")!, verificationCode: code.text!)

/*
		//電話番号のログイン
		Auth.auth().signIn(with: credential) { (user, error) in
		}
*/
		
		//匿名ユーザー使っての電話番号のログイン
		Auth.auth().currentUser?.link(with: credential) { (user, error) in
			
			if let error = error {
				print(error.localizedDescription)
			}else{
				
				// User is signed in
				print("Phone number: \(String(describing: user?.phoneNumber))")
				let userInfo = user?.providerData[0]
				print("Provider ID: \(String(describing: userInfo?.providerID))")
				self.performSegue(withIdentifier: "logged", sender: Any?.self)
				
				print("uid 2 =\(user!.uid)")
			}
			
		}
		
		
		
	}
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
