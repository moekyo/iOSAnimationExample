//
//  ViewController.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/3.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let examples = ["AnimatedCircle", "GooeySlideMenu", "DragBubbleView"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = examples[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
//            return
//        }
//
//        let cls = NSClassFromString((clsName as! String) + "." + examples[indexPath.row]) as! UIViewController.Type
//        let vc = cls.init()
//        vc.title = examples[indexPath.row]
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: examples[indexPath.row])
        show(vc, sender: nil)
        
        
    }
    
    
}
