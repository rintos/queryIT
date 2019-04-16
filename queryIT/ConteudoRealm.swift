//
//  ConteudoRealm.swift
//  queryIT
//
//  Created by Victor on 15/04/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import Foundation
import RealmSwift

class ConteudoRealm: Object {
    @objc dynamic var titulo: String? = nil
    @objc dynamic var texto: String? = nil
}

extension ConteudoRealm {
    func writeToRealm(){
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
}
