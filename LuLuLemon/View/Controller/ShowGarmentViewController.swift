//
//  ShowGarmentViewController.swift
//  LuLuLemon
//
//  Created by Preeti Priyam on 7/20/21.
//

import UIKit

class ShowGarmentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private var garmentViewModel = GarmentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.segue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SaveGarmentViewController
        vc.delegate = self
    }
    
    //to sort the garments by name and date
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            garmentViewModel.requestSort(by : Constants.name)
        }else {
            garmentViewModel.requestSort(by : Constants.date)
        }
        tableView.reloadData()
    }
    
}

extension ShowGarmentViewController : UITableViewDelegate, UITableViewDataSource, SaveGarmentDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garmentViewModel.getNumberOfGarments()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        cell?.textLabel!.text = garmentViewModel.garmentAtIndex(index: indexPath.row)?.garmentName
        return cell!
    }
    // function to send the new newgarment to viewModel to add it to core data
    func didAddGarment(garmentName: String) {
        print(garmentName)
        garmentViewModel.addGarment(name: garmentName)
        tableView.reloadData()
    }
    
}
