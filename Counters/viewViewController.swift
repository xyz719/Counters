//
//  ViewController.swift
//  Counters
//
//  Created by/Users/a20131105808/Desktop/Counters/Counters/ViewController.swift 20131105808 on 16/4/18.
//  Copyright © 2016年 20131105808. All rights reserv/Users/a20131105808/Desktop/Counters/Counters/ViewController.swifted.
//

import UIKit

class viewViewController: UIViewController {

    @IBAction func 历史记录(sender: UIButton) {
        initteam()
        initUser()
    }
    @IBOutlet weak var txt: UITextView!
    var db:SQLiteDB!
       override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        
        
        db.execute("create table if not exists t_team(uid integer primary key,team1 varchar(20),team2 varchar(20))")
        //如果有数据则加载
    }
    

    
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from t_user")
        for var a=0; a<data.count;a++ {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txt.text! += (user["uname"] as? String)!+"   "+(user["mobile"] as? String)!+"\n"
            
        }
        //
        
        
        
    }
    
    func initteam() {
        let data = db.query("select * from t_team")
        for var a=0;a<data.count;a++
        {
            //获取最后一行数据显示
            let team = data[data.count - 1]
            txt.text! = (team["team1"] as? String)!+"  "+(team["team2"] as? String)!+"\n"

        }
        
        
    }
    
    @IBAction func clean(sender: AnyObject) {
        let sql="DROP TABLE t_user;"
        print("sql:\(sql)")
        
        let result=db.execute(sql)
        print(result)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

