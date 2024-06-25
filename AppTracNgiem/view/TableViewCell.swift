//
//  TableViewCell.swift
//  AppTracNgiem
//
//  Created by thắng on 3/25/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Đăng ký cell tùy chỉnh
        tableView.register(UINib(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
        
        // Thiết lập delegate và datasource cho UITableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Trả về số lượng button bạn muốn hiển thị
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
        
        // Thiết lập tiêu đề cho các button trong cell
        cell.button1.setTitle("Button 1", for: .normal)
        cell.button2.setTitle("Button 2", for: .normal)
        cell.button3.setTitle("Button 3", for: .normal)
        cell.button4.setTitle("Button 4", for: .normal)
        cell.button5.setTitle("Button 5", for: .normal)
        cell.button6.setTitle("Button 6", for: .normal)
        cell.button7.setTitle("Button 7", for: .normal)
        cell.button8.setTitle("Button 8", for: .normal)
        cell.button9.setTitle("Button 9", for: .normal)
        
        // Thiết lập action cho các button nếu cần
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // Thiết lập chiều cao của cell
    }
}
