//
//  SecondViewController.swift
//  MyDemo
//
//  Created by 冷少白 on 2017/11/23.
//  Copyright © 2017年 Seven. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController{

    var session:AVCaptureSession?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true)
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
