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
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Создание контекста
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        //Описание сущности
//        let entityDescription = NSEntityDescription.entity(forEntityName: "ResultPoint", in: context)
        
        //Создание обьекта
//        let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
//        let managedObject = ResultPoint(entity: CoreDataManager.instatnce.entityForName(entityName: "ResultPoint"), insertInto: CoreDataManager.instatnce.context)
        let managedObject = ResultPoint()
        
        //Установка значений атрибутов
//        managedObject.setValue(1, forKey: "numberSet")
//        managedObject.setValue(25, forKey: "countSet")
        managedObject.numberSet = 3
        managedObject.countSet = 26
        
        //Извлекаем значение атрибутов
//        let numberSet = managedObject.value(forKey: "numberSet")
//        let countSet = managedObject.value(forKey: "countSet")
        let numberSet = managedObject.numberSet
        let countSet = managedObject.countSet
        print("\(numberSet),\(countSet)")
        
        
        // сохранение данных
//        appDelegate.saveContext()
        CoreDataManager.instatnce.saveContext()
        
        // Извлекаем данные
        let featchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultPoint")
        do{
            let results = try CoreDataManager.instatnce.context.fetch(featchRequest)
//            for result in results as! [NSManagedObject]{
//                print("number set - \(result.value(forKey: "numberSet")!), count set- \(result.value(forKey: "countSet")!)")
            for result in results as! [ResultPoint]{
                print("number set - \(result.numberSet), count set- \(result.countSet)")
            
            }
        }catch{
            print(error)
        }
        
        
        //  Удаление  ВСЕХ записей
//        do{
//            let results = try CoreDataManager.instatnce.context.fetch(featchRequest)
//            for result in results as! [NSManagedObject]{
//                CoreDataManager.instatnce.context.delete(result)
//            }
//        }catch{
//            print(error)
//        }
        
        //сохранить
        CoreDataManager.instatnce.saveContext()
        
    }
}
