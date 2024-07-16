//
//  DeThiController.swift
//  AppTracNgiem
//
//  Created by thắng on 3/27/24.
//

import UIKit
import CoreData

class ExammController: UITableViewController {
    
    // Định nghĩa số lượng nút bạn muốn hiển thị
    let numberOfButtons = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Khai báo TableView sử dụng self-sizing cells
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Trả về số lượng hàng trong section
        return numberOfButtons
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tạo cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath)

        // Tạo UIButton
        let button = UIButton(type: .system)
        button.setTitle("Button \(indexPath.row + 1)", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = indexPath.row

        // Xóa tất cả các subviews trong cell trước khi thêm nút mới
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }

        // Thêm nút vào cell
        cell.contentView.addSubview(button)

        // Đặt ràng buộc cho nút
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true

        return cell
    }

    // Xử lý sự kiện khi nút được nhấn
    @objc func buttonTapped(_ sender: UIButton) {
        print("Button \(sender.tag + 1) was tapped!")
        // Thực hiện các hành động tương ứng với việc nhấn nút
    }
}
