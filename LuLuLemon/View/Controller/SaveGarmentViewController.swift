//
//  SaveGarmentViewController.swift
//  LuLuLemon
//
//  Created by Preeti Priyam on 7/20/21.
//

import UIKit

protocol SaveGarmentDelegate {
    func didAddGarment(garmentName: String)
}

class SaveGarmentViewController: UIViewController {
    
    @IBOutlet weak var addGarmentTextFeild: UITextField!
    var delegate : SaveGarmentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //function send the receive the new garment and pass it to the home view
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let addGarmentTextFeild = addGarmentTextFeild else { return }
        if(addGarmentTextFeild.text != "") {
            delegate?.didAddGarment(garmentName: addGarmentTextFeild.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
