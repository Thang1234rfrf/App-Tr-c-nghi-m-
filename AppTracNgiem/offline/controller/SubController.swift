import UIKit

class TuluyenController: UIViewController {
    var selectedMon:  String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedMon = selectedMon {
                }
    }
    
    @IBAction func toan(_ sender: Any) {
    }

    // Truyền dữ liệu qua các màn hình
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue1" {
              if let destinationVC = segue.destination as? BaiThiController {
                destinationVC.selectedMon = "Toán"
              }
          } else if segue.identifier == "Segue2" {
              if let destinationVC = segue.destination as? BaiThiController {
                  destinationVC.selectedMon = "Lý"
              }
           
       }
   }
}
