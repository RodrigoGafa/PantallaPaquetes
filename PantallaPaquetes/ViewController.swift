//
//  ViewController.swift
//  PantallaPaquetes
//
//  Created by Rodrigo Nájera Rivas on 3/1/17.
//  Copyright © 2017 Rodrigo Nájera Rivas. All rights reserved.
//

import UIKit
import CreditCardValidator

class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let view = AgregarTarjeta.instanceFromNib
        
        self.view.addSubview(view())
        
        //AgregarTarjeta.setCardType()
        
       
        
        
        //Tarjeta.Guardar.layer.cornerRadius = 20
        //Tarjeta.Guardar.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

