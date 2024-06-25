import UIKit
import CoreData

class BaiLamController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var noidungcauhoi: UILabel!
    @IBOutlet weak var a: UILabel!
    @IBOutlet weak var b: UILabel!
    @IBOutlet weak var c: UILabel!
    @IBOutlet weak var d: UILabel!
    @IBOutlet weak var checkboxContainer: UIView!
    
    var buttonLabelMapping: [UIButton: UILabel] = [:]
    var dataArray: [String] = []
    
    var fetchedResultsController: NSFetchedResultsController<DeThiGdcd>!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var remainingTime = 20 * 60
    var timer: Timer?
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var items: [DeThiGdcd] = []
    var currentIndex = 0
    var totalDataCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        
        for (index, button) in checkboxContainer.subviews.enumerated() {
            guard let button = button as? UIButton else { continue }
            button.addTarget(self, action: #selector(checkBoxButtonTapped(_:)), for: .touchUpInside)
            button.tag = index
        }
        
        setupFetchedResultsController()
        displayData()
    }
    
    @objc func updateCountdown() {
        remainingTime -= 1
        
        if remainingTime <= 0 {
            timer?.invalidate()
            timeLabel.text = "Hết thời gian"
        } else {
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    @objc func checkBoxButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        // Truy cập đối tượng DeThiGdcd hiện tại từ fetchedResultsController
        guard let deThi = fetchedResultsController.fetchedObjects?[currentIndex] else {
            print("Không tìm thấy đối tượng DeThiGdcd tại chỉ mục \(currentIndex)")
            return
        }
        
        // Cập nhật thuộc tính dapAnChon của đối tượng DeThiGdcd hiện tại với nội dung đáp án tương ứng
        switch index {
        case 0:
            deThi.dapAnChon = a.text
        case 1:
            deThi.dapAnChon = b.text
        case 2:
            deThi.dapAnChon = c.text
        case 3:
            deThi.dapAnChon = d.text
        default:
            break
        }
        
        // Lưu đối tượng đã cập nhật vào Core Data
        do {
            try context.save()
            print("Đã lưu dapAnChon: \(deThi.dapAnChon ?? "Không xác định") cho câu hỏi tại chỉ mục \(currentIndex)")
        } catch {
            print("Lỗi khi lưu dapAnChon: \(error)")
        }
        
        // Kiểm tra nếu currentIndex vượt quá tổng số lượng dữ liệu, thiết lập lại currentIndex
        if currentIndex < totalDataCount - 1 {
            currentIndex += 1
            displayData()
        } else {
            print("Bạn đã hoàn thành tất cả các câu hỏi")
            // Bạn có thể điều hướng sang màn hình khác hoặc hiển thị thông báo hoàn thành
            // performSegue(withIdentifier: "showResults", sender: nil) // Ví dụ điều hướng sang màn hình kết quả
        }
        
        // Đặt trạng thái của UIButton được nhấn thành true
        sender.isSelected = true
        
        // Đặt hình ảnh cho UIButton được nhấn và hủy chọn các UIButton khác
        for case let button as UIButton in checkboxContainer.subviews where button != sender {
            button.isSelected = false
            button.setImage(UIImage(named: "checkbox_unchecked"), for: .normal)
        }
        
        if sender.isSelected {
            sender.setImage(UIImage(named: "checkbox_checked"), for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                sender.isSelected = false
                sender.setImage(UIImage(named: "checkbox_unchecked"), for: .normal)
            }
        }
    }

    
    func setupFetchedResultsController() {
        let request: NSFetchRequest<DeThiGdcd> = DeThiGdcd.fetchRequest() as! NSFetchRequest<DeThiGdcd>
        let sortDescriptor = NSSortDescriptor(key: "cau", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            totalDataCount = fetchedResultsController.fetchedObjects?.count ?? 0
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func displayData() {
        guard let deThi = fetchedResultsController.fetchedObjects?[currentIndex] else {
            return
        }
        noidungcauhoi.text = deThi.noiDungCauHoi
        a.text = deThi.a
        b.text = deThi.b
        c.text = deThi.c
        d.text = deThi.d
    }
}
