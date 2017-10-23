import UIKit

class NotesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var notesTableView: UITableView!
    let FirstNoteCell = "NoteCell"
    
    var noteKeeper: NoteKeeper?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, noteKeeper: NoteKeeper?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.noteKeeper = noteKeeper
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.noteKeeper = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let backButton = UIButton(type: .custom)
        backButton.setTitle("+", for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal) 
        backButton.addTarget(self, action: #selector(self.addNewNote(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.title = "Notes"
        
        notesTableView.register(CustomNoteTableViewCell.self, forCellReuseIdentifier: FirstNoteCell)
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.rowHeight = 50
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            notesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewNote(_ sender: UIBarButtonItem) {
        let addNoteViewController = AddNoteViewController(nibName: "AddNoteViewController", bundle: nil, noteKeeper: noteKeeper)
        // create navigation controller
        let navigationViewController = UINavigationController(rootViewController: addNoteViewController)
        self.present(navigationViewController, animated: true, completion: nil)
    }
}

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        guard let noteKeeper = noteKeeper else {return}
        print("Value: \(noteKeeper.notes[indexPath.row].title)")
        let addNoteViewController = AddNoteViewController(nibName: "AddNoteViewController", bundle: nil, noteKeeper: noteKeeper)
        addNoteViewController.setUpNote(noteKeeper.notes[indexPath.row])
        // create navigation controller
        let navigationViewController = UINavigationController(rootViewController: addNoteViewController)
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let noteKeeper = noteKeeper else {return 0}
        return noteKeeper.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirstNoteCell, for: indexPath as IndexPath) as! CustomNoteTableViewCell
        guard let noteKeeper = noteKeeper else {return UITableViewCell()}
        cell.setNoteKeeper(noteKeeper: noteKeeper)
        cell.textLabel!.text = "\(noteKeeper.notes[indexPath.row].title)"
        cell.noteId = indexPath.row
        return cell
    }
}

