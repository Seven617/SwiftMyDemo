//
//  ThirdViewController.swift
//  MyDemo
//
//  Created by 冷少白 on 2017/11/24.
//  Copyright © 2017年 Seven. All rights reserved.
//

import UIKit
import Toaster

class ThirdViewController: UIViewController {

  
    @IBOutlet weak var email: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "找回密码"
//        navigationItem.backBarButtonItem?.title = "返回"
//          navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sure(_ sender: Any) {
        let myemail = email.text!
        //应用通过邮箱修改密码
        BmobUser.requestPasswordResetInBackground(withEmail: myemail){(isSuccessful, error) in
            if isSuccessful {
                print("password update successfully")
                Toast(text: "已发送邮件至您的邮箱").show()
                self.dismiss(animated: true)
            }else{
                Toast(text: "修改密码失败").show()
                print("password update error\(String(describing: error))")
            }
        }
    }
    
    @IBAction func closekeyboard(_ sender: Any) {
        email.resignFirstResponder()
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
