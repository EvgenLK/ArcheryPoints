//
//  ViewController.swift
//  ArcheryPoints
//
//  Created by Evgenii Kutasov on 05.01.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        //Ссылка на appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Создание контекста
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Описание сущности
        let entityDescription = NSEntityDescription.entity(forEntityName: "ResultPoint", in: context)
        
        //Создание обьекта
        let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        //Установка значений атрибутов
        managedObject.setValue(2, forKey: "numberSet")
        managedObject.setValue(20, forKey: "countSet")
        
        //Извлекаем значение атрибутов
        let numberSet = managedObject.value(forKey: "numberSet")
        let countSet = managedObject.value(forKey: "countSet")
        print("\(numberSet),\(countSet)")
        //24:30
        
        // сохранение данных
        appDelegate.saveContext()
        
        // Извлекаем данные
        let featchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultPoint")
        do{
            let results = try context.fetch(featchRequest)
            for result in results as! [NSManagedObject]{
                print("number set - \(result.value(forKey: "numberSet")!), count set- \(result.value(forKey: "countSet")!)")
            }
        }catch{
            print(error)
        }
    }


}

