//
//  ViewController.swift
//  queryIT
//
//  Created by Victor on 03/04/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var listaContexto = [ConteudoRealm]()
    
    //referencia para instanciar/chamar dados firebase
    var referencia: DatabaseReference?
    
    //listener
    var textoDataBaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //criando a referencia
        referencia = Database.database().reference()
        
        //listener do campo DetailTexto do tableView
        textoDataBaseHandle = referencia?.child("contexto").observe(DataEventType.value, with: { snapshot in
            
                for dados in snapshot.children.allObjects as! [DataSnapshot]{
                    let dadosObjeto = dados.value as? [String: AnyObject]
                    if let dadosTitulo = dadosObjeto?["titulo"]{
                        if let dadosTexto = dadosObjeto?["texto"]{
                            let textos = ConteudoRealm()
                            textos.titulo = dadosTitulo as? String
                            textos.texto = dadosTexto as? String
                            self.listaContexto.append(textos)
                            self.tableView.reloadData()
                        }
                    }
                   
                }

        })

        //metodo nao seguro / nao recomendado
        //Adicionando dados no RealtimeDataBase
//        let dadosTitulo = referencia?.child("contexto").childByAutoId().child("titulo")
//        let dadosTexto = referencia?.child("contexto").childByAutoId().child("texto")
//        dadosTexto?.setValue("Domingo")
//        dadosTitulo?.setValue("Domingo texto 01 01")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaContexto.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaID", for: indexPath)
        
        let dado:ConteudoRealm
        dado = listaContexto[indexPath.row]
        celula.textLabel?.text = dado.titulo
        celula.detailTextLabel?.text = dado.texto
        
        return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        let dado: ConteudoRealm
        dado = listaContexto[indexPath.row]
        
        if let viewDestino = self.storyboard?.instantiateViewController(withIdentifier: "DetalheViewController") as? DetalheViewController {
            viewDestino.conteudo.texto = dado.texto
            viewDestino.conteudo.titulo = dado.titulo
            self.navigationController!.pushViewController(viewDestino, animated: true)
        }
    }
    
}

