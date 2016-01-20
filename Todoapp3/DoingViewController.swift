////
//  ViewController.swift
//  Todoapp
//
//  Created by Katsuya yamamoto on 2015/12/13.
//  Copyright (c) 2015年 nyalix. All rights reserved.
//

import UIKit

class DoingViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var doingEntities: [Doing]!
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        doingEntities = Doing.MR_findAll() as? [Doing]
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doingEntities = Doing.MR_findAll() as? [Doing]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doingEntities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DoingListItem") as! DoingListItemTableViewCell
        cell.titleLabel!.text = doingEntities[indexPath.row].item
        cell.subtitleLabel!.text = doingEntities[indexPath.row].date
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
            self.doingEntities.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            tableView.reloadData()
            //println("Rate button pressed")
        }
        
        let doingAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Done") { (action , indexPath) -> Void in
            
            tableView.editing = false
            
            let newDone: Done = Done.MR_createEntity() as Done
            newDone.item = self.doingEntities[indexPath.row].item
            newDone.date = self.doingEntities[indexPath.row].date
            
            self.doingEntities.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            tableView.reloadData()
            
            let alert = UIAlertView()
            alert.title = "Done!"
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
            let doingController = segue.destinationViewController as! DoingItemViewController
            let task = doingEntities[tableView.indexPathForSelectedRow!.row]
            doingController.doingtask = task
        }
    }
    
}


