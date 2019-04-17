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

    var dadosLista = [Conteudo]()
    
    //referencia para instanciar/chamar dados firebse
    var referencia: DatabaseReference?
    
    //listener
    var textoDataBaseHandle: DatabaseHandle?
    
//    var lista = [(titulo: "Endereco IP", texto: "Digite o comando ifconfig no terminal e tecle enter"),
//               (titulo: "Atalho selecionar", texto: "shift + optional seta para cima ou para baixo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
//        tableView.dataSource = self
       
        //criando a referencia
        referencia = Database.database().reference()
        
        //listener do campo DetailTexto do tableView
        textoDataBaseHandle = referencia?.child("contexto").observe(DataEventType.value, with: { (snapshot) in if snapshot.childrenCount > 0 {
            
          //  let contextoConteudo = snapshot.value as? NSDictionary
            
            for dados in snapshot.children.allObjects as! [DataSnapshot]{
                let dadosObjeto = dados.value as? [String: AnyObject]
                if let dadosTitulo = dadosObjeto?["titulo"]{
                    if let dadosTexto = dadosObjeto?["texto"]{
                        let textos = Conteudo(titulo: dadosTitulo as? String, texto: dadosTexto as? String)

                        self.dadosLista.append(textos)
                        self.tableView.reloadData()
                    }
                }
               
            }
            
        }

    })

//        //Adicionando dados no RealtimeDataBase
//        let dadosTitulo = referencia?.child("contexto").child("005").child("titulo")
//        let dadosTexto = referencia?.child("contexto").child("005").child("texto")
//        dadosTexto?.setValue("Alterei o indice do detalhe para indexPath.row pra funcionar")
//        dadosTitulo?.setValue("erro ao listar")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dadosLista.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaID", for: indexPath)
        
        let dado:Conteudo
        dado = dadosLista[indexPath.row]
        celula.textLabel?.text = dado.titulo
        celula.detailTextLabel?.text = dado.texto
        
        return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        let dado: Conteudo
        dado = dadosLista[indexPath.row]
        
        if let viewDestino = self.storyboard?.instantiateViewController(withIdentifier: "DetalheViewController") as? DetalheViewController {
            viewDestino.conteudo.texto = dado.texto
            viewDestino.conteudo.titulo = dado.titulo
            self.navigationController!.pushViewController(viewDestino, animated: true)
        }
    }
    
}

