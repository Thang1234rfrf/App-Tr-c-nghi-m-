import UIKit

class PasswordDialog {
    static func show(in viewController: UIViewController, password: String, completion: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "Nhập mật khẩu", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Mật khẩu"
            textField.isSecureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "Huỷ", style: .cancel) { (_) in
            completion(false)
        }
        
        let okAction = UIAlertAction(title: "Xác nhận", style: .default) { (_) in
            if let enteredPassword = alertController.textFields?.first?.text, enteredPassword == password {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
