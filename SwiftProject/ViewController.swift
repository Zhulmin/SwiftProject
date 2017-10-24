//
//  ViewController.swift
//  SwiftProject
//
//  Created by rain on 2017/10/13.
//  Copyright © 2017年 LoveRain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "SwiftProject"
        
        view.addSubview(tableView)
        
    }
    
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.rowHeight = 44
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ViewControllerCellId")
        return tableView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewControllerCellId")
        cell?.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "RAC / MVVM架构 / 登录功能"
            
        case 1:
            cell?.textLabel?.text = "GPUImage2 处理图片"
        case 2:
            cell?.textLabel?.text = "GPUImage2 视频添加水印 ✘"
        case 3:
            cell?.textLabel?.text = "GPUImage2 裁剪视频 ✘"
        case 4:
            cell?.textLabel?.text = "GPUImage2 拼接视频 ✘"
        case 5:
            cell?.textLabel?.text = "GPUImage2 录制视频并保存到相册"
            
        case 7:
            cell?.textLabel?.text = "视频编码解码 ✘"
        default:
            cell?.textLabel?.text = ""
            break
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc : UIViewController?
        
        switch indexPath.row {
        case 0:
            vc = LoginViewController()
        case 1:
            vc = MediaHandleController()
        case 5:
            vc = GPUCameraController()
        default:
            break
        }
        vc == nil ? nil :navigationController?.pushViewController(vc!, animated: true)
    }
}

