//
//  FirstViewController.swift
//  MyDemo
//
//  Created by 冷少白 on 2017/11/23.
//  Copyright © 2017年 Seven. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, UITextFieldDelegate {
    var uiswitch:UISwitch!
    var rememberlab:UILabel!
    //用户密码输入框
    var name:UITextField!
    var password:UITextField!

    //左手离脑袋的距离
    var offsetLeftHand:CGFloat = 60
    
    //左手图片,右手图片(遮眼睛的)
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    
    //左手图片,右手图片(圆形的)
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    //登录框状态
    var showType:LoginShowType = LoginShowType.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //去掉navigationBar的毛玻璃
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //去掉navigationBar底部黑线
        self.navigationController?.navigationBar.clipsToBounds = true
        
        //获取屏幕尺寸
        let mainSize = UIScreen.main.bounds.size
        
        //猫头鹰头部
        let imgLogin =  UIImageView(frame:CGRect(x: mainSize.width/2-211/2, y: 100, width: 211, height: 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        //猫头鹰左手(遮眼睛的)
        let rectLeftHand = CGRect(x: 61 - offsetLeftHand, y: 90, width: 40, height: 65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        //猫头鹰右手(遮眼睛的)
        let rectRightHand = CGRect(x: imgLogin.frame.size.width / 2 + 60, y: 90, width: 40, height: 65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        //登录框背景
        let vLogin =  UIView(frame:CGRect(x: 15, y: 200, width: mainSize.width - 30, height: 180))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        vLogin.backgroundColor = UIColor.white
        self.view.addSubview(vLogin)
        
        //猫头鹰左手(圆形的)
        let rectLeftHandGone = CGRect(x: mainSize.width / 2 - 100,
                                      y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgLeftHandGone)
        
        //猫头鹰右手(圆形的)
        let rectRightHandGone = CGRect(x: mainSize.width / 2 + 62,
                                       y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgRightHandGone)
        
        //用户名输入框
        name = UITextField(frame:CGRect(x: 30, y: 30, width: vLogin.frame.size.width - 60, height: 44))
        name.textAlignment = .center
        name.delegate = self
        name.layer.cornerRadius = 5
        name.layer.borderColor = UIColor.lightGray.cgColor
        name.returnKeyType=UIReturnKeyType.done
        name.layer.borderWidth = 0.5
        name.placeholder = "账号/邮箱/手机号"
        name.clearButtonMode=UITextFieldViewMode.whileEditing
        name.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        name.leftViewMode = UITextFieldViewMode.always
        name.addTarget(self, action: #selector(closenamekeyboard(_:)), for: .editingDidEndOnExit)
        //用户名输入框左侧图标
        let imgUser =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named:"iconfont-user")
        name.leftView!.addSubview(imgUser)
        vLogin.addSubview(name)
        
        //密码输入框
        password = UITextField(frame:CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44))
        password.delegate = self
        password.layer.cornerRadius = 5
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.isSecureTextEntry = true
        password.textAlignment = .center
        password.clearsOnBeginEditing = true
        password.placeholder = "请输入密码"
        password.keyboardType=UIKeyboardType.asciiCapable
        password.returnKeyType=UIReturnKeyType.done
        password.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        password.leftViewMode = UITextFieldViewMode.always
        password.clearButtonMode=UITextFieldViewMode.whileEditing
        password.addTarget(self, action: #selector(closepasswordkeyboard(_:)), for: .editingDidEndOnExit)
        //密码输入框左侧图标
        let imgPwd =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named:"iconfont-password")
        password.leftView!.addSubview(imgPwd)
        vLogin.addSubview(password)
        
        uiswitch = UISwitch(frame: CGRect(x: 50, y: 345, width: 0, height: 0))
        //设置位置（开关大小无法设置）
        //uiswitch.center = CGPoint(x:70, y:360)
        //设置默认值
        uiswitch.isOn = false;
        uiswitch.addTarget(self, action: #selector(switchDidChange), for:.valueChanged)
        self.view.addSubview(uiswitch);
        //记住密码lable
        rememberlab = UILabel(frame: CGRect(x: 105, y: 355, width: 100, height: 8))
        rememberlab.text = "记住密码"
        self.view.addSubview(rememberlab);
        
        remember()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func switchDidChange(){
        //打印当前值
        print(uiswitch.isOn)
        let userDefaults = UserDefaults.standard
        
        if(userDefaults.bool(forKey: "isRememberPsd"))
        {
            print("如果原来记住密码 现在忘记密码")
            userDefaults.set(false, forKey: "isRememberPsd")
        }
        else
        {
                print("如果原来忘记密码 现在记住密码")
                userDefaults.set(true, forKey: "isRememberPsd")
        }
        
        userDefaults.synchronize()
    }
    
    @IBAction func tosecond(_ sender: Any) {
        if(name.text?.isEmpty)!{
        Toast(text: "账号不能为空！").show()
        ToastView.appearance().backgroundColor = .blue
        }
        else if(password.text?.isEmpty)!{
        Toast(text: "密码不能为空！").show()
        ToastView.appearance().backgroundColor = .blue
        }
        else{
            login()
        }
    }
    
        //登录
    func login(){
        BmobUser.loginInbackground(withAccount: name.text, andPassword: password.text) { (user, error) in
            if user != nil {
//                let vc = SecondViewController(nibName: "SecondViewController", bundle: nil)
//                vc.labename = self.name.text!
//                vc.labepassword = self.password.text!
//                self.present(vc, animated: true)
                self.performSegue(withIdentifier: "tomain", sender: nil)
                let userDefaults = UserDefaults.standard
                if(userDefaults.bool(forKey: "isRememberPsd"))
                {
                userDefaults.set( self.name.text, forKey: "userName")
                userDefaults.set( self.password.text, forKey: "userPsw")
                }
                print("\(String(describing: user))")
            }else{
                print("error \(String(describing: error))")
                Toast(text: "登录失败").show()
            }
        }
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        //记住密码
    func remember(){
        let userDefaults = UserDefaults.standard
        if(userDefaults.bool(forKey: "isRememberPsd"))
        {
            uiswitch.isOn = true;
            print("我进来了")
            userDefaults.set(true, forKey: "isRememberPsd")
            let nm = userDefaults.string(forKey: "userName")
            let psd = userDefaults.string(forKey: "userPsw")
            print(nm!+psd!)
            self.name.text = userDefaults.string(forKey: "userName")
            self.password.text = userDefaults.string(forKey: "userPsw")
            
        }else{
            let userDefaults = UserDefaults.standard
            print("我又进来了")
            userDefaults.set(false, forKey: "isRememberPsd")
//            userDefaults.set("", forKey: "userName")
//            userDefaults.set("", forKey: "userPsw")
        }
    }

    
    func closenamekeyboard(_ sender: Any) {
        name.resignFirstResponder()
    }
    func closepasswordkeyboard(_ sender: Any) {
        password.resignFirstResponder()
        textFieldDidBeginEditing(name)
    }
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        //如果当前是用户名输入
        if textField.isEqual(name){
            if (showType != LoginShowType.pass)
            {
                showType = LoginShowType.user
                return
            }
            showType = LoginShowType.user
            
            //播放不遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRect(
                    x: self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
                    y: self.imgLeftHand.frame.origin.y + 30,
                    width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x: self.imgRightHand.frame.origin.x + 48,
                    y: self.imgRightHand.frame.origin.y + 30,
                    width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x: self.imgLeftHandGone.frame.origin.x - 70,
                    y: self.imgLeftHandGone.frame.origin.y, width: 40, height: 40)
                self.imgRightHandGone.frame = CGRect(
                    x: self.imgRightHandGone.frame.origin.x + 30,
                    y: self.imgRightHandGone.frame.origin.y, width: 40, height: 40)
            })
        }
            //如果当前是密码名输入
        else if textField.isEqual(password){
            if (showType == LoginShowType.pass)
            {
                showType = LoginShowType.pass
                return
            }
            showType = LoginShowType.pass
            
            //播放遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRect(
                    x: self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                    y: self.imgLeftHand.frame.origin.y - 30,
                    width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x: self.imgRightHand.frame.origin.x - 48,
                    y: self.imgRightHand.frame.origin.y - 30,
                    width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x: self.imgLeftHandGone.frame.origin.x + 70,
                    y: self.imgLeftHandGone.frame.origin.y, width: 0, height: 0)
                self.imgRightHandGone.frame = CGRect(
                    x: self.imgRightHandGone.frame.origin.x - 30,
                    y: self.imgRightHandGone.frame.origin.y, width: 0, height: 0)
            })
        }
    }
}

//登录框状态枚举
enum LoginShowType {
    case none
    case user
    case pass
}

