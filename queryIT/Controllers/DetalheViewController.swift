//
//  DetalheViewController.swift
//  queryIT
//
//  Created by Victor on 07/04/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import UIKit
import RealmSwift

class DetalheViewController: UIViewController {
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var textoTextView: UITextView!
    
    @IBOutlet weak var viewButtonSalvar: UIView!
    @IBOutlet weak var viewTextView: UIView!
    
    
    var conteudo = ConteudoRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tabBarController?.tabBar.isHidden = true
        self.tituloLabel.text = conteudo.titulo
        self.textoTextView.text = conteudo.texto
        
        self.viewButtonSalvar.layer.cornerRadius = 10
        self.viewTextView.layer.cornerRadius = 10

    }
    
    @IBAction func shareConteudo (_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [conteudo.titulo as Any, conteudo.texto as Any], applicationActivities: nil)

        present(activityController , animated: true)
    }
        
    func salvarDados(){
        let realm = try! Realm()
        
        let contexto = ConteudoRealm()
        contexto.titulo = conteudo.titulo
        contexto.texto = conteudo.texto
        
        try! realm.write {
            realm.add(contexto, update: true)
        }
    }
    
    @IBAction func salvarRealm(_ sender: Any) {

        salvarDados()
        print("dados Salvos no Realm com sucesso")
        navigationController?.popToRootViewController(animated: true)
    }


}
