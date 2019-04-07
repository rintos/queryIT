//
//  ViewController.swift
//  queryIT
//
//  Created by Victor on 03/04/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var referencia: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var textoDabaseHandle: DatabaseHandle?
    
    var listaFirebase = [String]()
    var listaFireBaseTexto = [String]()

    
    var lista = [ "Endereco IP", "Atalho selecionar"]
    
    
//    var lista = [(titulo: "Endereco IP", texto: "Digite o comando ifconfig no terminal e tecle enter"),
//               (titulo: "Atalho selecionar", texto: "shift + optional seta para cima ou para baixo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        referencia = Database.database().reference()
        
        databaseHandle = referencia?.child("contexto").observe(.childAdded, with: { (dados) in

            let contexto = dados.value as? NSDictionary

            if let meuContexto = contexto {
                let dadosConvertido = meuContexto["titulo"] as? String ?? ""
                self.listaFirebase.append(dadosConvertido)
                self.tableView.reloadData()

            }


        })
        
        textoDabaseHandle = referencia?.child("contexto").observe(.childAdded, with: { (snapshot) in
            
            let contextoConteudo = snapshot.value as? NSDictionary
            
            if let meuContextoConteudo = contextoConteudo {
                let conteudoConvertido = meuContextoConteudo["texto"] as? String ?? ""
                self.listaFireBaseTexto.append(conteudoConvertido)
                self.tableView.reloadData()
            }
        })

          print("teste de array: \(listaFirebase)")

//        let dadosTitulo = referencia?.child("contexto").child("004").child("titulo")
//        let dadosTexto = referencia?.child("contexto").child("004").child("texto")
//        dadosTexto?.setValue("Com ajuda da documentacao converti os dadosFirebase oara NSDictionary, converti o mesmo para array de String no if let")
//        dadosTitulo?.setValue("Finalmente Listantdo")
        


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaFirebase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaID", for: indexPath)
        let linha = indexPath.row
        celula.textLabel?.text = listaFirebase[linha]
        celula.detailTextLabel?.text = listaFireBaseTexto[linha]

        
        
        return celula
    }
    
    


}

