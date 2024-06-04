//
//  IAPManager.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 5/27/24.
//

import Foundation
import StoreKit
import KeychainAccess

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    static let shared = IAPManager()
    private override init() {
        super.init()
        inistializeKeychainValues()
        getPuchaseStates()
    }
    
    var productsRequest: SKProductsRequest!
    var availableProducts = [SKProduct]()
    
    
    public var isGrandPianoNotesPurchased: Bool = false
    public var isGuitarMajorChordsPurchased: Bool = false
    public var isKeyboardNotesPurchased: Bool = false
    public var isViolinNotesPurchased: Bool = false
    
    
    //MARK: - In App Purchases
    var productIDS: [String] = [
        //        "grandPiano69",
        //        "acousticGuitarMajorChords",
        //        "electronicKeyboard69",
        //        "violin420"
        "com.wylan.apps.KnowNotes2024.piano",
        "com.wylan.apps.KnowNotes2024.guitar",
        "com.wylan.apps.KnowNotes2024.keyboard",
        "com.wylan.apps.KnowNotes2024.violin"
    ]
    
    
    
    func getSpecificProductID(instrument: InstrumentType)-> String {
        switch instrument {
        case .BasicPiano:
            return ""
        case .GrandPiano:
            //        "grandPiano69"
            return "com.wylan.apps.KnowNotes2024.piano"
        case .AcousticGuitar:
            //        "acousticGuitarMajorChords"
            return "com.wylan.apps.KnowNotes2024.guitar"
        case .Keyboard:
            //        "electronicKeyboard69"
            return "com.wylan.apps.KnowNotes2024.keyboard"
        case .Violin:
            // "com.wylan.apps.KnowNotes2024.violin"
            return  "com.wylan.apps.KnowNotes2024.violin"
        }
    }
    
    func getInstrumentType(from productID: String) -> InstrumentType? {
        switch productID {
        case "com.wylan.apps.KnowNotes2024.piano": return InstrumentType.GrandPiano
        case "com.wylan.apps.KnowNotes2024.guitar": return InstrumentType.AcousticGuitar
        case "com.wylan.apps.KnowNotes2024.keyboard": return InstrumentType.Keyboard
        case "com.wylan.apps.KnowNotes2024.violin" : return InstrumentType.Violin
        default :
            return nil
        }
        
    }
    
    func getProductFrom(instrument:InstrumentType)->SKProduct{
        let id = getSpecificProductID(instrument: instrument)
        
        for p in availableProducts {
            if p.productIdentifier == id {
                return p
            }
        }
         
        return SKProduct()
    }
    
    func fetchProducts() {
        let productIdentifiers = Set(productIDS)
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest.delegate = self
        productsRequest.start()
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        availableProducts = response.products
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid product identifier: \(invalidIdentifier)")
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to fetch products: \(error.localizedDescription)")
    }
    
    func buyProduct(_ product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User cannot make payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                // Unlock content
                print("Purchase successful: \(transaction.payment.productIdentifier)")
                storePurchases(transaction: transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                if let error = transaction.error as NSError? {
                    print("Transaction failed: \(error.localizedDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // Restore content
                print("Purchase restored: \(transaction.payment.productIdentifier)")
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
    
    //MARK: - KeychainAccess
    
    private let serviceString: String = "com.wylan.apps.KnowNotes2024"
    private let grandPianoNotesKS: String = "GPNKS"
    private let acousticGuitarMajorChordsKS: String = "AGMCKS"
    private let keyboardNotesKS: String = "KNKS"
    private let violinNotesKS: String = "VNKS"
    
    func inistializeKeychainValues(){
        let keychain = Keychain(service: serviceString)

        // Check if the key exists
               do {
                   if let gPValue = try keychain.get(grandPianoNotesKS) {
                       print("Key exists with value: \(gPValue)")
                   } else {
                       print("Key does not exist, setting a new value")
                       try keychain.set("nil", key: grandPianoNotesKS)
                       print("New value set successfully")
                   }
               } catch let error {
                   print("Error: \(error)")
               }
        do {
            if let aGValue = try keychain.get(acousticGuitarMajorChordsKS) {
                print("Key exists with value: \(aGValue)")
            } else {
                print("Key does not exist, setting a new value")
                try keychain.set("nil", key: acousticGuitarMajorChordsKS)
                print("New value set successfully")
            }
        } catch let error {
            print("Error: \(error)")
        }
        
        do {
            if let keyboardNValue = try keychain.get(keyboardNotesKS) {
                print("Key exists with value: \(keyboardNValue)")
            } else {
                print("Key does not exist, setting a new value")
                try keychain.set("nil", key: keyboardNotesKS)
                print("New value set successfully")
            }
        } catch let error {
            print("Error: \(error)")
        }
        
        do {
            if let vNValue = try keychain.get(violinNotesKS) {
                print("Key exists with value: \(vNValue)")
            } else {
                print("Key does not exist, setting a new value")
                try keychain.set("nil", key: violinNotesKS)
                print("New value set successfully")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func getPuchaseStates(){
        let keychain = Keychain(service: serviceString)

        do {
            if let gPValue = try keychain.get(
                grandPianoNotesKS
            ) {
                if gPValue == "purchased" {
                    isGrandPianoNotesPurchased = true
                } else {
                    isGrandPianoNotesPurchased = false
                }
            } else {
                print(
                    "No value found"
                )
            }
        } catch let error {
            print(
                "Error retrieving value: \(error)"
            )
               }
        do {
            if let aGValue = try keychain.get(
                acousticGuitarMajorChordsKS
            ) {
                if aGValue == "purchased" {
                    isGuitarMajorChordsPurchased = true
                } else {
                    isGuitarMajorChordsPurchased = false
                }
            } else {
                print(
                    "No value found"
                )
            }
        } catch let error {
            print(
                "Error retrieving value: \(error)"
            )
               }
        do {
            if let kNValue = try keychain.get(
                keyboardNotesKS
            ) {
                if kNValue == "purchased" {
                    isKeyboardNotesPurchased = true
                } else {
                    isKeyboardNotesPurchased = false
                }
            } else {
                print(
                    "No value found"
                )
            }
        } catch let error {
            print(
                "Error retrieving value: \(error)"
            )
               }
        do {
            if let vNValue = try keychain.get(
                violinNotesKS
            ) {
                if vNValue == "purchased" {
                    isViolinNotesPurchased = true
                } else {
                    isViolinNotesPurchased = false
                }
            } else {
                print(
                    "No value found"
                )
            }
        } catch let error {
            print(
                "Error retrieving value: \(error)"
            )
               }
        
    }
    
    func checkIfPurchased(instrumentPack: InstrumentType)->Bool{
        
        switch instrumentPack {
        case .BasicPiano:
            return true
        case .GrandPiano:
            return isGrandPianoNotesPurchased
        case .AcousticGuitar:
            return isGuitarMajorChordsPurchased
        case .Keyboard:
            return isKeyboardNotesPurchased
        case .Violin:
            return isViolinNotesPurchased
        }
        
    }
    
    func storePurchases(transaction:SKPaymentTransaction){
        
        let keychain = Keychain(service: serviceString)
        
        if let  productInstrumentType = getInstrumentType(
            from: transaction.payment.productIdentifier
        ) {
            switch productInstrumentType {
            case .BasicPiano:
                break
            case .GrandPiano:
                do {
                    try keychain.set("purchased", key: grandPianoNotesKS)
                    print(
                        "GrandPianoNotes purchase stored successfully"
                    )
                } catch let error {
                    print(
                        "Error storing GrandPianoNotes purchased"
                    )
                        }
            case .AcousticGuitar:
                do {
                    try keychain.set("purchased", key: acousticGuitarMajorChordsKS)
                    print(
                        "AcousticGuitarMajorChords purchase stored successfully"
                    )
                } catch let error {
                    print(
                        "Error storing AcousticGuitarMajorChords purchased"
                    )
                        }
            case .Keyboard:
                do {
                    try keychain.set("purchased", key: keyboardNotesKS)
                    print(
                        "KeyboardNotes purchase stored successfully"
                    )
                } catch let error {
                    print(
                        "Error storing KeyboardNotes purchased"
                    )
                        }
            case .Violin:
                do {
                    try keychain.set("purchased", key: violinNotesKS)
                    print(
                        "ViolinNotes purchase stored successfully"
                    )
                } catch let error {
                    print(
                        "Error storing ViolinNotes purchased"
                    )
                        }
            }
        }
        getPuchaseStates()
    }
    
    
    
    
    
}

   
enum IAPStatus {
    case purchased
    case not
}

