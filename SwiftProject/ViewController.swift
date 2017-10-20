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
        
        let tableView = UITableView(frame: view.bounds, style: .plain)
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
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewControllerCellId")
        cell?.selectionStyle = .none
        if indexPath.row == 1 {
            cell?.textLabel?.text = "MVVM / RAC / LoginVc"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc : UIViewController?
        if indexPath.row == 1 {
            vc = LoginViewController()
        }
        vc == nil ? nil :navigationController?.pushViewController(vc!, animated: true)
    }
}

