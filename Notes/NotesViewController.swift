import UIKit

class NotesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var notesTableView: UITableView!
    let FirstNoteCell = "NoteCell"
    
    var noteKeeper: NoteKeeper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let addButton = UIButton(type: .custom)
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(addButton.tintColor, for: .normal) 
        addButton.addTarget(self, action: #selector(self.addNewNote(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.title = "Notes"
        
        notesTableView.register(MyCustomCell.self, forCellReuseIdentifier: "myCell")
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.rowHeight = 50
        
        // fix tableview separators 
        notesTableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewNote(_ sender: UIBarButtonItem) {
        let addNoteViewController = AddNoteViewController()
        addNoteViewController.noteKeeper = noteKeeper
        // create navigation controller
        let navigationViewController = UINavigationController(rootViewController: addNoteViewController)
        self.present(navigationViewController, animated: true, completion: nil)
    }
}

extension NotesViewController: UITableViewDelegate, CustomCellDelegate {
    
    func changeUISwitchStatus(cellId: Int, isOn: Bool) {
        if  cellId != -1 {
            noteKeeper.notes[cellId].isDone = isOn
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(noteKeeper.notes[indexPath.row].title)")
        print("Value: \(noteKeeper.notes[indexPath.row].isDone)")

        let addNoteViewController = AddNoteViewController()
        addNoteViewController.row = indexPath.row
        addNoteViewController.noteKeeper = noteKeeper
        addNoteViewController.savedNote = noteKeeper.notes[indexPath.row]
        // create navigation controller
        let navigationViewController = UINavigationController(rootViewController: addNoteViewController)
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteKeeper.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! MyCustomCell
        
        tableView.register(UINib.init(nibName: "MyCustomCell", bundle: nil), forCellReuseIdentifier: "myCell")
        cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! MyCustomCell
 
        return cell
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let c = cell as! MyCustomCell
        c.cellLabel!.text = "\(noteKeeper.notes[indexPath.row].title)"
        c.delegate = self
        c.switchButtonIsDonе!.isOn = noteKeeper.notes[indexPath.row].isDone
        c.cellId = indexPath.row

    }
}

