////
//  ViewController.swift
//  Todoapp
//
//  Created by Katsuya yamamoto on 2015/12/13.
//  Copyright (c) 2015年 nyalix. All rights reserved.
//

import UIKit

class TodoViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    

var todoEntities: [Todo]!
    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        todoEntities = Todo.MR_findAll() as? [Todo]
        tableView.reloadData()
    }

override func viewDidLoad() {
    super.viewDidLoad()
    
    todoEntities = Todo.MR_findAll() as? [Todo]
        // Do any additional setup after loading the view, typically from a nib.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoEntities.count
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TodoListItem") as! TodoListItemTableViewCell
    cell.titleLabel!.text = todoEntities[indexPath.row].item
    cell.subtitleLabel!.text = todoEntities[indexPath.row].date
    return cell
}


    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    
    
    
    //スワイプを利用する
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    //スワイプイベント
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delateAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Delete") { (action , indexPath ) -> Void in

            tableView.editing = false
            self.todoEntities.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            tableView.reloadData()
            //println("Rate button pressed")
        }
        
        let doingAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Doing") { (action , indexPath) -> Void in
            
            tableView.editing = false
            
            let newDoing: Doing = Doing.MR_createEntity() as Doing
            newDoing.item = self.todoEntities[indexPath.row].item
            newDoing.date = self.todoEntities[indexPath.row].date
            
            self.todoEntities.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            tableView.reloadData()
            
            let alert = UIAlertView()
            alert.title = "Doing!"
            //  alert.message = "message"
            //  alert.addButtonWithTitle("OK")
            alert.show()
            alert.dismissWithClickedButtonIndex(0, animated: false)
            
            
        }
        delateAction.backgroundColor = UIColor.redColor()
        doingAction.backgroundColor = UIColor.blueColor()
        
        return [delateAction, doingAction]
    }
    
    
    //タップで編集
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit" {
            //let todoController = segue.destinationViewController as! EditViewController
            let todoController = segue.destinationViewController as! TodoItemViewController
            let task = todoEntities[tableView.indexPathForSelectedRow!.row]
            todoController.task = task
        }
    }
    
}


