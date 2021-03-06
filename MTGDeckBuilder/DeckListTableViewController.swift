//
//  DeckListTableViewController
//  MTGPrices
//
//  Created by Gabriele Pregadio on 11/28/16.
//  Copyright © 2016 Gabriele Pregadio. All rights reserved.
//

import UIKit
import Alamofire
import ReSwift
import ObjectMapper

class DeckListTableViewController: UITableViewController, StoreSubscriber {
    
    // MARK: - Properties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var decks = [Deck]()
    
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        title = "Decks"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Decks", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(showSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDeck))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        store.dispatch(ReceivedMemoryWarning(restorationIdentifier: restorationIdentifier!))
    }
    
    
    // MARK: - Methods
    
    @objc private func showSettings() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifiers.settings.rawValue) as? SettingsTableViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func addDeck() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifiers.editDeck.rawValue) as? EditDeckTableViewController {
            vc.isCreatingNewDeck = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - StoreSubscriber Delegate Methods
    
    func newState(state: RootState) {
        if let error = state.coreDataState.coreDataError {
            switch error {
            case .loadingError(let description): present(errorAlert(description: description, title: "Loading Error"), animated: true)
            case .savingError(let description): present(errorAlert(description: description, title: "Saving Error"), animated: true)
            case .otherError(let description): present(errorAlert(description: description, title: nil), animated: true)
            }
            return
        }
        
        self.decks = state.coreDataState.decks
        tableView.reloadData()
    }
    
}
