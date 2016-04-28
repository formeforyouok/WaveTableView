//
//  ViewController.swift
//  WaveTableView
//
//  Created by ZhanHao on 16/4/28.
//  Copyright © 2016年 zhanhao. All rights reserved.
//

import UIKit


public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController {

    private var tableView : UITableView!
    
    private var beginAnimateBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiconfig()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func uiconfig() {
        tableView = UITableView(frame: self.view.bounds,style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        beginAnimateBtn = UIButton(frame : CGRectMake(0,ScreenHeight - 49,ScreenWidth,49))
        beginAnimateBtn.setTitle("BeginAnimation", forState: UIControlState.Normal)
        beginAnimateBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        beginAnimateBtn.addTarget(self, action: #selector(ViewController.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(beginAnimateBtn)
    }
    
    func btnClick(btn : UIButton) {
        tableView.reloadDataAnimate(WaveAnimation.RightToLeftWaveAnimation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellid : String = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellid,forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = "Row: \(indexPath.row)"
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
}

