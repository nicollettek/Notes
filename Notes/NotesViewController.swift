import UIKit

class NotesViewController: UIViewController, UITableViewDataSource {

    var navigationViewController: UINavigationController?
    @IBOutlet weak var notesTableView: UITableView!
    let FirstNoteCell = "NoteCell"
    
    func setNavigationViewControler(_ navigationViewController:UINavigationController) {
        self.navigationViewController = navigationViewController
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
        let addNoteViewController = AddNoteViewController(nibName: "AddNoteViewController", bundle: nil)
        self.navigationViewController?.pushViewController(addNoteViewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(NoteKeeper.sharedInstance.notes[indexPath.row].title)")
        let addNoteViewController = AddNoteViewController(nibName: "AddNoteViewController", bundle: nil)
        addNoteViewController.setUpNote(NoteKeeper.sharedInstance.notes[indexPath.row])
        self.navigationViewController?.pushViewController(addNoteViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteKeeper.sharedInstance.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirstNoteCell, for: indexPath as IndexPath) as! CustomNoteTableViewCell
        cell.textLabel!.text = "\(NoteKeeper.sharedInstance.notes[indexPath.row].title)"
        cell.noteId = indexPath.row
        return cell
    }
}

