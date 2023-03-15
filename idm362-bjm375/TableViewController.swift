//
//  TableViewController.swift
//  idm362-bjm375
//
//  Created by Benji Moon on 3/14/23.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {

    
    
    var fNames: [String] = ["You got it!", "Keep pushing!", "Don't stop now!", "Stay motivated!", "Be happy!"]
    
    var exerciseObj: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContent = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        
        do {
            exerciseObj = try managedContent.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return fNames.count
        return exerciseObj.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

//         Configure the cell...

//        cell.textLabel?.text = fNames[indexPath.row]
        
        let workoutObj = exerciseObj[indexPath.row]
        
        cell.textLabel?.text = workoutObj.value(forKey: "name") as? String
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
//            fNames.remove(at: indexPath.row)
            let oneWorkout = exerciseObj[indexPath.row]
            
            context.delete(oneWorkout)
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                exerciseObj = try context.fetch(Exercise.fetchRequest())
                print("Fetching done" + String(exerciseObj.count))
            } catch {
                print("Fetching error")
            }
        
            
            
            
            tableView.reloadData()
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

    
    @IBAction func addWork(_ sender: Any) {
        
        let alertObj = UIAlertController(title: "New Workout", message: "Add new workout", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alertObj.textFields?.first,
                  let nameTosave = textField.text else {
            return
            }
//            self.fNames.append(nameTosave)
            self.saveToCore(name: nameTosave)
            
            
            
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .cancel)
        
        alertObj.addTextField()
        alertObj.addAction(saveAction)
        alertObj.addAction(cancelAction)
        
        present(alertObj, animated: true)
    }
    
    func saveToCore(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContent = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContent)!
        
        let workoutObj = NSManagedObject(entity: entity, insertInto: managedContent)
        
        workoutObj.setValue(name, forKey: "name")
        
        do {
            try managedContent.save()
            exerciseObj.append(workoutObj)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
    
    // MARK: - Navigation

    var selRowNum:Int = 0
    var selRowName:String = ""
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected " + indexPath.row.description)
        selRowNum = indexPath.row
        selRowName = fNames[selRowNum]
        
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let detailObj = segue.destination as! DetailsViewController
            detailObj.ndxNum = selRowNum
            detailObj.incomingName = selRowName
        }
        
    }
    

}
