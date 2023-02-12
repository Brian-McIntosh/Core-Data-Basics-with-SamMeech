import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        /*
         context is what we care about most - CRUD
         This is a NSManagedContext that we don't have to create ourselves
         Runs on the main thread (i.e. the name "viewContext")
         [later on: create your own contexts and run them on diff. threads]
         */
        
        // CREATE instances:
        let myCat = Cat(context: context) //<-- 1. didn't need to create a Cat class
        myCat.name = "Apollo"              //<-- 2. pass the context to the constructor
        myCat.age = 15
        
        let yourCat = Cat(context: context)
        yourCat.name = "Nio"
        yourCat.age = 1
        
        /*
         At this point, I've created the objects, BUT I HAVEN'T SAVE THEM.
         Also, I don't have any UI to display them...
         HOW to check that this is working?? use a NSFetchRequest
         */
        
        // QUERY CoreData:
        let catFetch: NSFetchRequest<Cat> = Cat.fetchRequest() //<-- don't need to import CoreData until this point
        // returns an array of [Cat]
        
        var cats: [Cat] = []
        
        do {
            cats = try context.fetch(catFetch)
        } catch {
            print("Error upon fetching CoreData data")
        }
        
        print(cats)
        cats.forEach { cat in
            print("\(cat.name!) is \(cat.age) years old.")
        }
        
        // SAVE:
        do {
            try context.save()
        } catch {
            print("Error upon saving to Core Data")
        }
        
    }


}

