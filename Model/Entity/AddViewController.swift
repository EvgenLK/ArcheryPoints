//
//  AddViewController.swift
//  ArcheryPoints
//
//  Created by Evgenii Kutasov on 06.01.2023.
//

import UIKit

class AddViewController: UIViewController {
    var resPoint: ResultPoint?

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: Any) {
        if saveResultPoint(){
            dismiss(animated: true,completion: nil)
        }
    }
    @IBOutlet weak var numberTextField: UITextField!
    
    
    @IBOutlet weak var countTextField: UITextField!
    
    
    @IBOutlet weak var countSilder: UISlider!
    

    @IBAction func silderCount(_ sender: UISlider) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // чтение обьекта
        if let resPoint = resPoint{
            numberTextField.text = String(resPoint.numberSet)
            countTextField.text = String(resPoint.countSet)
        }
    }

    func saveResultPoint() -> Bool{
        if countTextField.text!.isEmpty{
            let alert = UIAlertController(title: "Ошибка ввода", message: "Поле с суммой очков не заполнены", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        if resPoint == nil{
            resPoint = ResultPoint()
        }
        // сохранить обьект
        if let resPoint = resPoint{
            resPoint.countSet = Int16(countTextField.text!)!
            resPoint.numberSet = Int16(numberTextField.text!)!
            CoreDataManager.instatnce.saveContext()
        }
        return true
    }
}
