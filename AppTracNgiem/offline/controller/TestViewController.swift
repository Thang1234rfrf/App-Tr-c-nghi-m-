//
//  TestViewController.swift
//  AppTracNgiem
//
//  Created by thắng on 4/27/24.
//

import UIKit
import CoreData

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tt(_ sender: Any) {
        addDataToCoreData()
        fetchAndPrintData()
    }
    func addDataToCoreData() {
          
        // Dữ liệu cần thêm vào Core Data
        let dataToAdd: [[String: Any]] = [
            [
                "maDe": "gdcd1",
                "cau": 5,
                "noiDungCauHoi": "Nội dung nào dưới đây không thuộc nội dung công dân bình đẳng về quyền và nghĩa vụ?",
                "a": "Công dân bình đẳng về nghĩa vụ đóng góp vào quỹ từ thiện.",
                "b": "Công dân bình đẳng về nghĩa vụ đóng thuế.",
                "c": "Công dân bình đẳng về quyền bầu cử.",
                "d": "Công dân bình đẳng về nghĩa vụ bảo vệ Tổ quốc.",
                "dapAnDung": "Công dân bình đẳng về nghĩa vụ đóng góp vào quỹ từ thiện."
            ],
            [
                "maDe": "gdcd1",
                "cau": 4,
                "noiDungCauHoi": "Mỗi công dân khi có điều kiện theo quy định của pháp luật đều có quyền kinh doanh là thể hiện công dân bình đẳng",
                "a": "trong sản xuất.",
                "b": "trong kinh tế.",
                "c": "về quyền và nghĩa vụ.",
                "d": "về điều kiện kinh doanh.",
                "dapAnDung": "về quyền và nghĩa vụ."
            ],
            [
                "maDe": "gdcd1",
                "cau": 3,
                "noiDungCauHoi": "Quyền và nghĩa vụ công dân không bị phân biệt bởi dân tộc, giới tính và địa vị xã hội là thể hiện quyền bình đẳng nào dưới đây của công dân?",
                "a": "Bình đẳng về thành phần xã hội.",
                "b": "Bình đẳng quyền và nghĩa vụ.",
                "c": "Bình đẳng tôn giáo.",
                "d": "Bình đẳng dân tộc.",
                "dapAnDung": "Bình đẳng quyền và nghĩa vụ."
            ],
            [
                "maDe": "gdcd1",
                "cau": 2,
                "noiDungCauHoi": "Bất kỳ công dân nào vi phạm pháp luật đều phải bị xử lý theo quy định của pháp luật là thể hiện bình đẳng về",
                "a": "trách nhiệm pháp lý",
                "b": "quyền và nghĩa vụ.",
                "c": "thực hiện pháp luật",
                "d": "trách nhiệm trước Tòa án",
                "dapAnDung": "trách nhiệm pháp lý"
            ],
            [
                "maDe": "gdcd1",
                "cau": 1,
                "noiDungCauHoi": "Mỗi công dân đều được hưởng quyền và phải thực hiện nghĩa vụ theo quy định của pháp luật là biểu hiện công dân bình đẳng về",
                "a": "quyền và nghĩa vụ.",
                "b": "quyền và trách nhiệm",
                "c": "nghĩa vụ và trách nhiệm",
                "d": "trách nhiệm và pháp lý",
                "dapAnDung": "quyền và nghĩa vụ."
            ]
        ]

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

//        for data in dataToAdd {
//            let entity = NSEntityDescription.entity(forEntityName: "DeThiGdcd", in: managedContext)!
//            let deThiGDCD = NSManagedObject(entity: entity, insertInto: managedContext)
//            deThiGDCD.setValue(data["maDe"], forKeyPath: "maDe")
//            deThiGDCD.setValue(data["cau"], forKeyPath: "cau")
//            deThiGDCD.setValue(data["noiDungCauHoi"], forKeyPath: "noiDungCauHoi")
//            deThiGDCD.setValue(data["a"], forKeyPath: "a")
//            deThiGDCD.setValue(data["b"], forKeyPath: "b")
//            deThiGDCD.setValue(data["c"], forKeyPath: "c")
//            deThiGDCD.setValue(data["d"], forKeyPath: "d")
//            deThiGDCD.setValue(data["dapAnDung"], forKeyPath: "dapAnDung")
//
//        }
        do {
            try managedContext.save()
            print("Dữ liệu đã được thêm vào Core Data")
        } catch let error as NSError {
            print("Không thể thêm dữ liệu vào Core Data. Lỗi: \(error), \(error.userInfo)")
        }
    
    
    
    

    // Tạo một fetch request để lấy các câu cần xóa
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeThiGdcd")
   fetchRequest.predicate = NSPredicate(format: "cau == 0")

    do {
        // Thực hiện fetch request để lấy các câu cần xóa
        let results = try managedContext.fetch(fetchRequest)

       // Xóa các câu được tìm thấy
        for object in results {
            managedContext.delete(object)
        }

        // Lưu thay đổi vào Core Data
        try managedContext.save()
       print("Dữ liệu đã được xóa từ Core Data")
   } catch let error as NSError {
        print("Không thể xóa dữ liệu từ Core Data. Lỗi: \(error), \(error.userInfo)")
    }

        
    }
    
    
    func fetchAndPrintData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeThiGdcd")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            for data in results {
                let maDe = data.value(forKey: "maDe") as? String ?? ""
                let cau = data.value(forKey: "cau") as? Int ?? 0
                let noiDungCauHoi = data.value(forKey: "noiDungCauHoi") as? String ?? ""
                let a = data.value(forKey: "a") as? String ?? ""
                let b = data.value(forKey: "b") as? String ?? ""
                let c = data.value(forKey: "c") as? String ?? ""
                let d = data.value(forKey: "d") as? String ?? ""
                let dapAnDung = data.value(forKey: "dapAnDung") as? String ?? ""
                
                print("Ma đề: \(maDe)")
                print("Câu: \(cau)")
                print("Nội dung câu hỏi: \(noiDungCauHoi)")
                print("Đáp án A: \(a)")
                print("Đáp án B: \(b)")
                print("Đáp án C: \(c)")
                print("Đáp án D: \(d)")
                print("Đáp án đúng: \(dapAnDung)")
                print("--------------")
            }
            
        } catch let error as NSError {
            print("Không thể lấy dữ liệu từ Core Data. Lỗi: \(error), \(error.userInfo)")
        }
    }

}
