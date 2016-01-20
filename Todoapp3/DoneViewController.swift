////
//  ViewController.swift
//  Todoapp
//
//  Created by Katsuya yamamoto on 2015/12/13.
//  Copyright (c) 2015年 nyalix. All rights reserved.
//

import UIKit

class DoneViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var doneEntities: [Done]!
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        doneEntities = Done.MR_findAll() as? [Done]
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneEntities = Done.MR_findAll() as? [Done]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doneEntities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DoneListItem") as! DoneListItemTableViewCell
        cell.titleLabel!.text = doneEntities[indexPath.row].item
        cell.subtitleLabel!.text = doneEntities[indexPath.row].date
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
            self.doneEntities.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            tableView.reloadData()
            //println("Rate button pressed")
        }
        
                delateAction.backgroundColor = UIColor.redColor()
        
        return [delateAction]
    }
    
    
    //タップで編集
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit" {
            //let todoController = segue.destinationViewController as! EditViewController
            let doneController = segue.destinationViewController as! DoneItemViewController
            let task = doneEntities[tableView.indexPathForSelectedRow!.row]
            doneController.donetask = task
        }
    }
    
}


