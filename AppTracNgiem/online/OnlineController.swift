import UIKit
import FirebaseFirestore

class OnlineController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
//    @IBOutlet weak var view: UIView!
    var dataArray: [ScoreEntry] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Đăng ký UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreEntryCell")
        
        // Lấy dữ liệu từ Firestore
        fetchData()
    }
    
    @IBAction func menu(_ sender: Any) {
    }
    
    func fetchData() {
        db.collection("exams").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.dataArray = querySnapshot?.documents.compactMap { document in
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let creator = data["creator"] as? String ?? ""
                    let score = data["score"] as? Int ?? 0
                    let password = data["password"] as? String ?? ""
                    let content = data["content"] as? String ?? ""


                    return ScoreEntry(name: name, time: time, creator: creator, score: score, password: password, content:content)
                } ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreEntryCell", for: indexPath)
        
        let entry = dataArray[indexPath.row]
        
        // Tạo label cho tên
        let nameLabel = UILabel()
        nameLabel.text = entry.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)  // Font đậm, size 16
        nameLabel.textColor = UIColor.black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Tạo label cho tên người tạo
        let creatorLabel = UILabel()
        creatorLabel.text = "Creator: \(entry.creator)"
        creatorLabel.font = UIFont.systemFont(ofSize: 14)  // Font thông thường, size 14
        creatorLabel.textColor = UIColor.gray
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Xóa tất cả các subviews cũ của cell
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Thêm các label vào contentView của cell
        cell.contentView.addSubview(nameLabel)
        cell.contentView.addSubview(creatorLabel)
        
        // Layout constraints cho nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
        ])
        
        // Layout constraints cho creatorLabel
        NSLayoutConstraint.activate([
            creatorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            creatorLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            creatorLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            creatorLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8)
        ])
        
        // Đảm bảo rằng autoresizing mask được thiết lập đúng để có thể sử dụng constraints
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return cell
    }


    // Nếu muốn hiển thị chi tiết hơn, có thể tùy chỉnh cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = dataArray[indexPath.row]
        var name = entry.content
        // Hiện dialog yêu cầu nhập mật khẩu
        PasswordDialog.show(in: self, password: entry.password) { (success) in
            if success {
                // Mật khẩu đúng, chuyển đến màn hình AssignmentController bằng modal presentation
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detailVC = storyboard.instantiateViewController(withIdentifier: "AssignmentController") as? AssignmentController {
                    detailVC.name = name
                    detailVC.modalPresentationStyle = .fullScreen // Hoặc chọn modalPresentationStyle phù hợp
                    self.present(detailVC, animated: true, completion: nil)
                }
            } else {
                // Mật khẩu sai hoặc đã hủy
                print("Nhập mật khẩu sai hoặc đã hủy")
            }
        }
        
        // Bỏ chọn hàng đã chọn
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
}
struct ScoreEntry {
    let name: String
    let time: String
    let creator: String
    let score: Int
    let password: String
    let content: String


}
