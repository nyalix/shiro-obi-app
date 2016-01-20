//
//  Todo.swift
//  
//
//  Created by Katsuya yamamoto on 2015/12/13.
//  Copyright (c) 2015年 nyalix. All rights reserved.
//

import Foundation
import CoreData

@objc(Todo)
class Todo: NSManagedObject {

    @NSManaged var item: String
    @NSManaged var date: String

}
