//
//  deThiToan.swift
//  AppTracNgiem
//
//  Created by thắng on 4/15/24.
//

import Foundation
import CoreData

class deThiToan: NSManagedObject {
    @NSManaged var a: String
    @NSManaged var b: String
    @NSManaged var c: String
    @NSManaged var d: String
    @NSManaged var dapAnChon: String
    @NSManaged var dapAnDung: String
    @NSManaged var maDe: String
    @NSManaged var noiDungCauHoi: String
    @NSManaged var cau: String
    @NSManaged var loiGiai: String

}
