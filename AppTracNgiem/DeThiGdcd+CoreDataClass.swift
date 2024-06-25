//
//  DeThiGdcd+CoreDataClass.swift
//  AppTracNgiem
//
//  Created by thắng on 4/16/24.
//
//

import Foundation
import CoreData

@objc(DeThiGdcd)
public class DeThiGdcd: NSManagedObject {
    
    @NSManaged public var a: String?
    @NSManaged public var b: String?
    @NSManaged public var c: String?
    @NSManaged public var cau: Int32
    @NSManaged public var d: String?
    @NSManaged public var dapAnChon: String?
    @NSManaged public var dapAnDung: String?
    @NSManaged public var loiGiai: String?
    @NSManaged public var maDe: String?
    @NSManaged public var noiDungCauHoi: String?


}
