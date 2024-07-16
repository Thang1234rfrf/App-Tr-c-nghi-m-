import UIKit
import FirebaseFirestore

class AssignmentController: UIViewController {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var a: UILabel!
    @IBOutlet weak var b: UILabel!
    @IBOutlet weak var c: UILabel!
    @IBOutlet weak var d: UILabel!
    @IBOutlet weak var button: UIView!
    
    var buttonLabelMapping: [UIButton: UILabel] = [:]
    var dataArray: [QuestionEntry] = []
    var totalDataCount = 0
    var currentIndex = 0
    var name: String? 
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckboxButtons()
        fetchDataFromFirestore()
        if let name = self.name {
                   // Ví dụ: In ra giá trị name lên console
                   print("Name: \(name)")
               } else {
                   print("Name is nil or empty")
               }
    }
    
    func setupCheckboxButtons() {
        for (index, button) in button.subviews.enumerated() {
            guard let button = button as? UIButton else { continue }
            button.addTarget(self, action: #selector(checkBoxButtonTapped(_:)), for: .touchUpInside)
            button.tag = index
            if let label = button.subviews.compactMap({ $0 as? UILabel }).first {
                buttonLabelMapping[button] = label
            }
        }
    }
    
    @objc func checkBoxButtonTapped(_ sender: UIButton) {
        guard currentIndex < totalDataCount else {
            print("Bạn đã hoàn thành tất cả các câu hỏi")
            return
        }
        
        let index = sender.tag
        
        // Update selected answer for current question
        let selectedOption: String
        switch index {
        case 0: selectedOption = "A"
        case 1: selectedOption = "B"
        case 2: selectedOption = "C"
        case 3: selectedOption = "D"
        default: return
        }
        
        var currentQuestion = dataArray[currentIndex]
        currentQuestion.selectedAnswer = selectedOption
        if currentIndex < totalDataCount - 1 {
            currentIndex += 1
            displayQuestion()
        } else {
            print("Bạn đã hoàn thành tất cả các câu hỏi")
            return
        }
        // Đặt trạng thái của UIButton được nhấn thành true
        sender.isSelected = true
        
        // Đặt hình ảnh cho UIButton được nhấn và hủy chọn các UIButton khác
        for case let button as UIButton in button.subviews where button != sender {
            button.isSelected = false
            button.setImage(UIImage(named: "checkbox_unchecked"), for: .normal)
        }
        if currentIndex == totalDataCount - 1 {
            if sender.isSelected {
                sender.setImage(UIImage(named: "checkbox_checked"), for: .normal)
                
            }
            
        }
        if currentIndex < totalDataCount - 1 {
            if sender.isSelected {
            sender.setImage(UIImage(named: "checkbox_checked"), for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                sender.isSelected = false
                sender.setImage(UIImage(named: "checkbox_unchecked"), for: .normal)
            }
            }
            }

        
        // Update UI to reflect selected answer
        for (button, label) in buttonLabelMapping {
            button.isSelected = (button == sender)
            label.textColor = (button.isSelected ? UIColor.blue : UIColor.black)
        }
    }

    func fetchDataFromFirestore() {
       
        let components = name?.components(separatedBy: ";@") ?? []

        // Khởi tạo mảng dataArray từ các thành phần
        dataArray = components.compactMap { component in
            return QuestionEntry(fromString: component)
        }
            self.totalDataCount = self.dataArray.count
            self.displayQuestion()
        
    }

    func displayQuestion() {
        guard currentIndex < totalDataCount else {
            print("Bạn đã hoàn thành tất cả các câu hỏi")
            return
        }
        
        let currentQuestion = dataArray[currentIndex]
        content.text = currentQuestion.content
        a.text = currentQuestion.optionA
        b.text = currentQuestion.optionB
        c.text = currentQuestion.optionC
        d.text = currentQuestion.optionD
        
        // Clear previous selection
        for button in buttonLabelMapping.keys {
            button.isSelected = false
        }
    }
}

struct QuestionEntry {
    var content: String // Nội dung câu hỏi
    var optionA: String // Lựa chọn A
    var optionB: String // Lựa chọn B
    var optionC: String // Lựa chọn C
    var optionD: String // Lựa chọn D
    var selectedAnswer: String? = nil // Câu trả lời đã chọn
    
    init?(fromString string: String) {
        let components = string.components(separatedBy: "?")
        
        guard components.count == 2 else {
            return nil
        }
        
        self.content = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
        let optionsString = components[1]
        
        let options = optionsString.components(separatedBy: ".;")
        
        guard options.count == 4 else {
            return nil
        }
        
        self.optionA = options[0].trimmingCharacters(in: .whitespacesAndNewlines)
        self.optionB = options[1].trimmingCharacters(in: .whitespacesAndNewlines)
        self.optionC = options[2].trimmingCharacters(in: .whitespacesAndNewlines)
        self.optionD = options[3].trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
