
import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [Today]()
    @Published var list1 = [Weightlogger]()
    @Published var todaysum = 0
    @Published var weeklist = [Weekdata]()
    @Published var goalscomplete = 0
    
    func goals(){
        goalscomplete=0
        for s in weeklist{
            if (1200...1650).contains(s.Totalcal){
                goalscomplete=goalscomplete+1
            }
        }
    }
    func getweekdata() {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Read the documents at a specific path
        db.collection("Weeklist").getDocuments { snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                self.goals()
                if let snapshot = snapshot {
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents
                        self.weeklist = snapshot.documents.map { d in
                            return Weekdata(id: d.documentID,
                                            Day: d["day"] as? String ?? "",
                                            Totalcal: d["totalcal"] as? Int ?? 0)
                        }
                    }
                }
            }
            else {
                // Handle the error
            }
        }
    }
    
    func deleteData(todoToDelete: Today) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        
        db.collection("Todaylist").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                self.weekData()
                
                if let snapshot = snapshot {
                    
                    self.todaysum=0
                    
                    for doc in snapshot.documents
                    {
                        self.todaysum = self.todaysum+Int(doc["cal"] as? String ?? "")!
                    }
                    self.weekData()
                    self.getweekdata()
                }
            }
        }
        db.collection("Todaylist").document(todoToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.list.removeAll { todo in
                        
                        // Check for the todo to remove
                        return todo.id == todoToDelete.id
                    }
                    
                }
                
                
            }
        }
    }
    func deleteDataweight(todoToDelete: Weightlogger) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("Weightlist").document(todoToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // self.getDataweight()
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.list.removeAll { todo in
                        
                        // Check for the todo to remove
                        return todo.id == todoToDelete.id
                    }
                }
            }
        }
        
    }
    
    
    
    func weekData() {
        
        var day = ""
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        day = dateFormatter.string(from: Date())
        let dayid=["Sunday":"1ZFINJYnS1UrBcCy3Zly",
                   "Monday":"A0Q479l2BiHAGsEeb0KR",
                   "Tuesday":"CkppXFtZWUcdJ1Q394XE",
                   "Wednesday":"XdUZCOzMOJBensyoVFNS",
                   "Thursday":"aPXYxuKSfmz4Ci3G8ete",
                   "Friday":"bcBf0w07XEBOQKKQmhls",
                   "Saturday":"dobeqTjqgQ7vtU4KSqo7",
        ]
        //Get a reference to the database
        let db = Firestore.firestore()
        
        
        // Add a document to a collection
        db.collection("Weeklist").document(dayid[day]!).setData(["totalcal":self.todaysum,"day":day], merge: true)
        { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call get data to retrieve latest data
            }
            else {
                // Handle the error
            }
        }
        
    }
    func addData(item: String, cal: String) {
        
        //Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("Todaylist").addDocument(data: ["item":item, "cal":cal]) { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call get data to retrieve latest data
                self.getData()
            }
            else {
                // Handle the error
            }
        }
    }
    func addDataweight(date: String, weight: String) {
        
        //Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("Weightlist").addDocument(data: ["date":date, "weight":weight]) { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call get data to retrieve latest data
                self.getDataweight()
            }
            else {
                // Handle the error
            }
        }
    }
    
    func getData() {
        
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("Todaylist").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    self.todaysum=0
                    
                    
                    for doc in snapshot.documents
                    {
                        self.todaysum = self.todaysum+Int(doc["cal"] as? String ?? "")!
                    }
                    self.weekData()
                    self.getweekdata()
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { d in
                            
                            // Create a Todo item for each document returned
                            return Today(id: d.documentID,
                                         Item: d["item"] as? String ?? "",
                                         Cal: d["cal"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                // Handle the error
            }
        }
    }
    
    func getDataweight() {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Read the documents at a specific path
        db.collection("Weightlist").getDocuments { snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.list1 = snapshot.documents.map { d in
                            
                            // Create a Todo item for each document returned
                            return Weightlogger(id: d.documentID,
                                                date: d["date"] as? String ?? "",
                                                weight: d["weight"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                // Handle the error
            }
        }
    }
}
