//
//  MyTableViewController.swift
//  ArcheryPoints
//
//  Created by Evgenii Kutasov on 06.01.2023.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController {

    struct Constants {
        static let entity = "ResultPoint"
        static let numberSet = "numberSet"
        static let cellName = "Cell"
        static let identifier = "tableInAddVC"
    }
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        let sortDescriptor = NSSortDescriptor(key: Constants.numberSet, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instatnce.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController

    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultController.delegate = self

        do{
            try fetchResultController.performFetch()
        }catch{
            print(error)
        }
        
        //удаляем разлиновки пустых полей
        tableView.tableFooterView = UIView()
        
        //большой заголовок
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections{
            return sections[section].numberOfObjects
        }else{
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)

        let point = fetchResultController.object(at: indexPath) as! ResultPoint
        cell.textLabel?.text = String(point.numberSet)
        cell.detailTextLabel?.text = String(point.countSet)
        

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let respoint = fetchResultController.object(at: indexPath) as! ResultPoint
        performSegue(withIdentifier: Constants.identifier, sender: respoint)
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let respoint = fetchResultController.object(at: indexPath) as! ResultPoint
            CoreDataManager.instatnce.context.delete(respoint)
            CoreDataManager.instatnce.saveContext()
        
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.identifier{
            let controller = segue.destination as! AddViewController
            controller.resPoint = sender as? ResultPoint
        }
    }
    

}

extension MyTableViewController: NSFetchedResultsControllerDelegate{
    
    // информируем о начале изменнеия данных
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
 
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?  ){
        switch type {
        case .insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath{
                let respoint = fetchResultController.object(at: indexPath) as! ResultPoint
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = String(respoint.numberSet)
                cell?.detailTextLabel?.text = String(respoint.countSet)
            }
        case .move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    // информируем об окончание изменени данных
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
