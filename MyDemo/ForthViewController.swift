//
//  ForthViewController.swift
//  MyDemo
//
//  Created by 冷少白 on 2017/11/25.
//  Copyright © 2017年 Seven. All rights reserved.
//

import UIKit
import Toaster
class ForthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //注册
    func signup(){
        let user = BmobUser()
        user.username = singoname.text
        user.password = singopassword.text
        user.email = singoemail.text
        //        user.mobilePhoneNumber = "18857040800"
        //        user.setObject(23, forKey: "age")
        user.signUpInBackground { (isSuccessful, error) in
            if isSuccessful {
                print("Sign up successfully")
                self.dismiss(animated: true)
            }else{
                Toast(text: "注册失败").show()
                print("Sign up error\(String(describing: error))")
            }
        }
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBOutlet weak var singoname: UITextField!
    
    @IBOutlet weak var singopassword: UITextField!
    
    @IBOutlet weak var singoemail: UITextField!
    //确认按钮点击事件
    @IBAction func sure(_ sender: Any) {
        signup()
    }
    @IBAction func closesnameboard(_ sender: Any) {
    }
    
    @IBAction func closespasswordkeyboard(_ sender: Any) {
    }
    
    @IBAction func closesemailcloseboard(_ sender: Any) {
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
