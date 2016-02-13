//
//  TodoItemViewController.swift
//  Todoapp
//
//  Created by Katsuya yamamoto on 2015/12/13.
//  Copyright (c) 2015年 nyalix. All rights reserved.
//

import UIKit

class TodoItemViewController: UIViewController, UITextViewDelegate{
    
    var task: Todo? = nil

    
    @IBOutlet weak var todoField: UITextView!
    // textViewの底辺のy座標用
    @IBOutlet weak var bottomField: NSLayoutConstraint!
    @IBAction func cancel(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    
    @IBAction func save(sender: UIBarButtonItem) {
        if task != nil {
            editTask()
        } else {
            createTask()
        }
        navigationController!.popViewControllerAnimated(true)
    }
    
    func createTask() {
        let newTask: Todo = Todo.MR_createEntity() as Todo
        newTask.item = todoField.text
        
        //let newDeta = NSDate()
        let dateFormatter = NSDateFormatter()                        // フォーマットの取得
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")  // JPロケール
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"               // フォーマットの指定
        newTask.date = dateFormatter.stringFromDate(NSDate())       // 現在日時
        newTask.managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }
    
    func editTask() {
        task?.item = todoField.text
        task?.managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デバイスごとのスクリーン幅を取得
        let width = UIScreen.mainScreen().bounds.width
        // ボタンビュー作成
        let myKeyboard = UIView(frame: CGRectMake(0, 0, width, 40))
        myKeyboard.backgroundColor = UIColor(red:0.93,green:0.93,blue:0.93,alpha:1.0)
        // Doneボタン作成
        let myButton = UIButton(frame: CGRectMake(width - 60, 5, 60, 30))
        myButton.backgroundColor = UIColor(red:0.93,green:0.93,blue:0.93,alpha:1.0)
        myButton.setTitle("Done", forState: .Normal)
        myButton.setTitleColor(UIColor(red:0.1,green:0.5,blue:1.0,alpha:1.0), forState: .Normal)
        myButton.layer.cornerRadius = 3
        myButton.addTarget(self, action: "onMyButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        // ボタンをビューに追加
        myKeyboard.addSubview(myButton)
        
        // ビューをフィールドに設定
        todoField.inputAccessoryView = myKeyboard
        todoField.delegate = self
        
        if let taskTodo = task {
            todoField.text = taskTodo.item
        }
        // Do any additional setup after loading the view.
    }
    func onMyButton () {
        if task != nil {
            editTask()
        } else {
            createTask()
        }
        self.view.endEditing(true )
    }
    
 
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillChangeFrame:",
            name: UIKeyboardWillChangeFrameNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyBoardValue : NSValue = userInfo[UIKeyboardFrameEndUserInfoKey]! as! NSValue
            let keyBoardFrame : CGRect = keyBoardValue.CGRectValue()
            let duration : NSTimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
            //let bottom = self.bottomField
            self.bottomField.constant =  40 - keyBoardFrame.size.height
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let duration : NSTimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
            self.bottomField.constant = 0
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
