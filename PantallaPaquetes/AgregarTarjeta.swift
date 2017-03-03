//
//  AgregarTarjeta.swift
//  PantallaPaquetes
//
//  Created by Rodrigo Nájera Rivas on 3/1/17.
//  Copyright © 2017 Rodrigo Nájera Rivas. All rights reserved.
//

import Foundation
import UIKit
import CreditCardValidator


class AgregarTarjeta: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK OUTLET IMAGES
    @IBOutlet var VisaCard: UIImageView!
    @IBOutlet var Master: UIImageView!
    @IBOutlet var Amex: UIImageView!
    
    //MARK TEXTFIELDS
    @IBOutlet var Nombre: UITextField!
    @IBOutlet var NoTarjeta: UITextField!
    @IBOutlet var Mes: UITextField!
    @IBOutlet var Año: UITextField!
    @IBOutlet var CVV: UITextField!
    
    //MARK LABELS
    @IBOutlet var NombreLabel: UILabel!
    @IBOutlet var NoTarjetaLabel: UILabel!
    @IBOutlet var mesLabel: UILabel!
    @IBOutlet var añoLabel: UILabel!
    @IBOutlet var CVVLabel: UILabel!
    
    
    // MARK BUTTON GUARDAR
    @IBOutlet var Guardar: UIButton!
    
    let pickerOptions:[String] = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    
    let datePicker = UIDatePicker()
    
    var creditCardValidator: CreditCardValidator!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "AgregarTarjeta", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView

    }
    
    
    override func awakeFromNib() {
        
        Guardar.layer.cornerRadius = 25
        
        NoTarjeta.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

        // MARK CARD VALIDATION
        
            // 5300 MasterCard
            // 4000 Visa
            // 3712 AmericanExpress
        
        
        creditCardValidator = CreditCardValidator()

       
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            self.Nombre.text = "Rodrigo Najera"
            //self.NoTarjeta.text = "3712 5691 0360 4567"
            self.Mes.text = "01"
            self.Año.text = "2019"
            self.CVV.text = "123"
        #endif
   
        //MARK TAP GESTURES
        let NombreGesture = UITapGestureRecognizer(target: self, action: #selector(nombreResponder))
        let NoTarjetaGesture = UITapGestureRecognizer(target: self, action: #selector(NoTarjetaResponder))
        let MesGesture = UITapGestureRecognizer(target: self, action: #selector(MesResponder))
        let AñoGesture = UITapGestureRecognizer(target: self, action: #selector(AñoResponder))
        let CVVGesture = UITapGestureRecognizer(target: self, action: #selector(CVVResponder))

        
        NombreLabel.isUserInteractionEnabled = true
        NombreLabel.addGestureRecognizer(NombreGesture)
        
        NoTarjetaLabel.isUserInteractionEnabled = true
        NoTarjetaLabel.addGestureRecognizer(NoTarjetaGesture)
        
        mesLabel.isUserInteractionEnabled = true
        mesLabel.addGestureRecognizer(MesGesture)
        
        añoLabel.isUserInteractionEnabled = true
        añoLabel.addGestureRecognizer(AñoGesture)
        
        
        CVVLabel.isUserInteractionEnabled = true
        CVVLabel.addGestureRecognizer(CVVGesture)
        
        // MARK PICKER VIEW
        
        let pickerView:UIPickerView = UIPickerView()
        
        pickerView.delegate = self
        
        pickerView.dataSource = self
        
        pickerView.backgroundColor = .white
        
        Mes.inputView = pickerView
        
        let toolbar:UIToolbar = UIToolbar()
        
        toolbar.sizeToFit()
        
        toolbar.tintColor = .gray
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneEditing))
        
        toolbar.setItems([doneButton], animated: false)
        
        Mes.inputAccessoryView = toolbar
        
        
    
    }
    
    func textFieldChanged(sender: UITextField){
        if let number = sender.text {
            if number.isEmpty {
                Amex.image = #imageLiteral(resourceName: "AmericanExpressWhite")
                VisaCard.image = #imageLiteral(resourceName: "VisaWhite")
                Master.image = #imageLiteral(resourceName: "MasterCardWhite")
            } else {
                detectCardNumberType(number: number)
            }
        }
    }
    
    func doneEditing(){
    
            // Add implementation in real project
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Mes.text = pickerOptions[row]
    }
    
    func nombreResponder(sender:UITapGestureRecognizer) {
        
        Nombre.becomeFirstResponder()
        
    }
    
    func NoTarjetaResponder(sender:UITapGestureRecognizer) {
        
        NoTarjeta.becomeFirstResponder()
        
    }
    
    func MesResponder(sender:UITapGestureRecognizer) {
        
        Mes.becomeFirstResponder()
    }
    
    func AñoResponder(sender:UITapGestureRecognizer) {
        
        Año.becomeFirstResponder()
        
    }
    
    func CVVResponder(sender:UITapGestureRecognizer) {
        
        CVV.becomeFirstResponder()
        
    }
    
    
    /**
     Credit card type detection
     
     - parameter number: credit card number
     */
    func detectCardNumberType(number: String) {
        if let type = creditCardValidator.type(from: number) {
            print("Type Name -> \(type.name)")
            if let type = creditCardValidator.type(from: number) {
                
                var cardType = type.name
                
                switch cardType {
                    
                case "MasterCard":
                    
                    cardType = type.name
                    Master.image = #imageLiteral(resourceName: "MasterCard")
                    VisaCard.image = #imageLiteral(resourceName: "VisaWhite")
                    Amex.image = #imageLiteral(resourceName: "AmericanExpressWhite")
                    
                case "Visa":
                    
                    cardType = type.name
                    VisaCard.image = #imageLiteral(resourceName: "Visa")
                    Master.image = #imageLiteral(resourceName: "MasterCardWhite")
                    Amex.image = #imageLiteral(resourceName: "AmericanExpressWhite")


                    
                case "Amex":
                    
                    cardType = type.name
                    Amex.image = #imageLiteral(resourceName: "AmericanExpress")
                    VisaCard.image = #imageLiteral(resourceName: "VisaWhite")
                    Master.image = #imageLiteral(resourceName: "MasterCardWhite")

                    
                default:
                    print("Error in switch")
                }
            } else {
                // I Can't detect type of credit card
                print("Error")
            }
        }
    }
    
   
}
