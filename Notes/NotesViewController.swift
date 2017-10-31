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
        
        notesTableView.register(UINib.init(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
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
        addNoteViewController.delegate = self
        // create navigation controller
        let navigationViewController = UINavigationController(rootViewController: addNoteViewController)
        self.present(navigationViewController, animated: true, completion: nil)
    }
}

extension NotesViewController: UITableViewDelegate, NoteTableViewCellDelegate, AddNoteViewControllerDelegate {

    func updateTitleAndContent(_ addNoteViewController: AddNoteViewController, title: String, content: String, noteId: Int) {
        if noteId == -1 {
            let note = Note(title: title, content: content)
            let noteIsAdded = noteKeeper.addNote(note: note)
            if !noteIsAdded {
                print("Note not added")
            }
        } else {
            noteKeeper.notes[noteId].title = title
            noteKeeper.notes[noteId].content = content
        }
    }
    
    func changeUISwitchStatus(_ noteTableViewCell: NoteTableViewCell, cellId: Int, isOn: Bool) {
        if  cellId != -1 {
            noteKeeper.notes[cellId].isDone = isOn
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(noteKeeper.notes[indexPath.row].title)")
        print("Value: \(noteKeeper.notes[indexPath.row].isDone)")

        let addNoteViewController = AddNoteViewController()
        addNoteViewController.delegate = self
        addNoteViewController.noteTitle = noteKeeper.notes[indexPath.row].title
        addNoteViewController.noteContent = noteKeeper.notes[indexPath.row].content
        addNoteViewController.noteId = indexPath.row
        
        // create navigation controller
        let navigationViewController = UINavigationController(rootViewController: addNoteViewController)
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteKeeper.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! NoteTableViewCell
        cell.cellLabel!.text = "\(noteKeeper.notes[indexPath.row].title)"
        cell.delegate = self
        cell.switchButtonIsDonе!.isOn = noteKeeper.notes[indexPath.row].isDone
        cell.cellId = indexPath.row
        return cell
    }
}

