//
//  ViewController.swift
//  Counters
//
//  Created by 20131105808 on 16/4/18.
//  Copyright © 2016年 20131105808. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var time:NSTimer!//建立一个计时器
    var db:SQLiteDB!
    @IBOutlet var txtzhudui: UITextField!
    @IBOutlet var txtkedui: UITextField!
    var a=0
    var b=0
    var x=12//分钟
    var y=1//秒
    @IBAction func one(sender: UIButton) {
        a=a+1
        txtzhudui.text=("\(a)")
        
    }
    @IBOutlet weak var la2: UILabel!
    @IBOutlet weak var la1: UILabel!
    @IBAction func two(sender: UIButton) {
        a=a+2
        txtzhudui.text=("\(a)")
    }
    @IBAction func three(sender: UIButton) {
        a=a+3
        txtzhudui.text=("\(a)")
    }
    @IBAction func one1(sender: UIButton) {
        b=b+1
        txtkedui.text=("\(b)")
    }
    @IBAction func one2(sender: UIButton) {
        b=b+2
        txtkedui.text=("\(b)")
    }

    @IBAction func one3(sender: UIButton) {
        b=b+3
        txtkedui.text=("\(b)")
    }
    @IBAction func start(sender: UIButton) {
        time=NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("dec"), userInfo: nil, repeats: true)
        txtzhudui.text="0"
        txtkedui.text="0"
        
    }
    @IBAction func stop(sender: UIButton) {
        time.invalidate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        db.execute("create table if not exists t_team(uid integer primary key,team1 varchar(20),team2 varchar(20))")
        
        //如果有数据则加载
        initUser()
    }
    
    //点击保存
    @IBAction func saveClicked(sender: AnyObject) {
        saveUser()
        saveteam()
    }
    
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtzhudui.text = user["uname"] as? String
            txtkedui.text = user["mobile"] as? String
        }
        //
        
        
        
    }
    func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtzhudui.text = user["uname"] as? String
            txtkedui.text = user["mobile"] as? String
        }
        //
        
        
        
    }
    
    //保存数据到SQLite
    func saveteam() {
        let team1 = self.team1.text!
        let team2 = self.team2.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into t_team(team1,team2) values('\(team1)','\(team2)')"
        print("sql: \(sql)")
        
        
        
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    }
    
    func dec()
    {
        y-=1
        while y==0
        {
            x=x-1
            y=60
        }
        la1.text=String(x)
        la2.text=String(y)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

