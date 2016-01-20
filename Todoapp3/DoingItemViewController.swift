//
//  TodoItemViewController.swift
//  Todoapp
//
//  Created by Katsuya yamamoto on 2015/12/13.
//  Copyright (c) 2015年 nyalix. All rights reserved.
//

import UIKit

class DoingItemViewController: UIViewController {
    
    var doingtask: Doing? = nil

    
    @IBOutlet weak var todoField: UITextView!
    @IBAction func cancel(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)

    }
    
    
    @IBAction func save(sender: UIBarButtonItem) {
        //
        //        let newTask: Todo = Todo.MR_createEntity() as Todo
        //        newTask.item = makeTodo.text
        //        newTask.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        //        //self.dismissViewControllerAnimated(true, completion: nil)
        //        navigationController!.popViewControllerAnimated(true)
        //    }
        //   @IBAction func clickSave(sender: UIBarButtonItem) {
        if doingtask != nil {
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
        let dateFormatter = NSDateFormatter()                                   // フォーマットの取得
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")  // JPロケール
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"         // フォーマットの指定
        newTask.date = dateFormatter.stringFromDate(NSDate())                // 現在日時

        newTask.managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }
    
    func editTask() {
        doingtask?.item = todoField.text
        doingtask?.managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let taskTodo = doingtask {
            todoField.text = taskTodo.item
        }
        // Do any additional setup after loading the view.
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
