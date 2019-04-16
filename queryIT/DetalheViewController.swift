//
//  DetalheViewController.swift
//  queryIT
//
//  Created by Victor on 07/04/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import UIKit

class DetalheViewController: UIViewController {
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var textoTextView: UITextView!
    
    var titulo: String = ""
    var texto: String = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tituloLabel.text = titulo
        self.textoTextView.text = texto

    }
    


}
