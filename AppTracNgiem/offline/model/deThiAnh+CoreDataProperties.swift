//
//  deThiAnh+CoreDataProperties.swift
//  AppTracNgiem
//
//  Created by thắng on 4/16/24.
//
//

import Foundation
import CoreData


@objc(deThiAnh)
public class deThiAnh: NSManagedObject {

}

extension deThiAnh {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<deThiAnh> {
        return NSFetchRequest<deThiAnh>(entityName: "DeThiAnh")
    }

    @NSManaged public var a: String?
    @NSManaged public var b: String?
    @NSManaged public var c: String?
    @NSManaged public var cau: String?
    @NSManaged public var d: String?
    @NSManaged public var dapAnChon: String?
    @NSManaged public var dapAnDung: String?
    @NSManaged public var loiGiai: String?
    @NSManaged public var maDe: String?
    @NSManaged public var noiDungCauHoi: String?

}

extension deThiAnh : Identifiable {

}
