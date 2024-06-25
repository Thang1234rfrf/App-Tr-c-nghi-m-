import UIKit
import CoreData
class NopbaiController: UIViewController {

    @IBOutlet weak var correctCountLabel: UILabel!
    @IBOutlet weak var dapan: UITextView!
    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Lấy managed object context từ AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedObjectContext = appDelegate.persistentContainer.viewContext

        // Gọi hàm fetch để lấy dữ liệu từ CoreData và hiển thị lên label
        fetchAllData()
    }

    func fetchAllData() {
        let fetchRequest: NSFetchRequest<DeThiGdcd> = DeThiGdcd.fetchRequest()  as! NSFetchRequest<DeThiGdcd>


        do {
                let questions = try managedObjectContext.fetch(fetchRequest)
                let attributedText = NSMutableAttributedString()
                var correctCount = 0 // Biến đếm số lần đúng

                for question in questions {
                    // Tạo các phần của câu hỏi
                    let questionText = "Câu hỏi: \(question.noiDungCauHoi ?? "")\n"
                    let dapAnChonText = "Đáp án chọn: \(question.dapAnChon ?? "")\n"

                    // Kiểm tra đáp án đúng có tồn tại hay không
                    let dapAnDungText: String
                    if let dapAnDung = question.dapAnDung {
                        dapAnDungText = "Đáp án đúng: \(dapAnDung)\n\n"
                        // Kiểm tra đáp án chọn có giống đáp án đúng hay không
                        if question.dapAnChon == dapAnDung {
                            correctCount += 1 // Tăng biến đếm nếu đúng
                        }
                    } else {
                        dapAnDungText = "Đáp án đúng: [Thiếu đáp án đúng]\n\n"
                    }

                    // Tạo attributed string cho từng phần và thiết lập màu sắc
                    let attributedQuestion = NSAttributedString(string: questionText)
                    let attributedDapAnChon = NSAttributedString(string: dapAnChonText, attributes: [NSAttributedString.Key.foregroundColor: question.dapAnChon == question.dapAnDung ? UIColor.green : UIColor.red])
                    let attributedDapAnDung: NSAttributedString

                    if let dapAnDung = question.dapAnDung {
                        attributedDapAnDung = NSAttributedString(string: dapAnDungText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]) // Màu đen cho dòng đáp án đúng
                    } else {
                        attributedDapAnDung = NSAttributedString(string: dapAnDungText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow]) // Màu vàng cho dòng thiếu đáp án đúng
                    }

                    // Thêm từng phần vào attributedText
                    attributedText.append(attributedQuestion)
                    attributedText.append(attributedDapAnChon)
                    attributedText.append(attributedDapAnDung)
                }

                // Hiển thị tổng chuỗi lên label
                dapan.attributedText = attributedText

                // Cập nhật số lần đúng lên label
                correctCountLabel.text = "Số lần đúng: \(correctCount)"

            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
}
