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
    private override init() {}
    
    var productsRequest: SKProductsRequest!
    var availableProducts = [SKProduct]()
    
    
    public var grandPianoStatus: IAPStatus = .not
    public var guitarMajorChords: IAPStatus = .not
    public var keyboard: IAPStatus = .not
    public var violin: IAPStatus = .not
    
    
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
            
        
            
        
    
    }
    
    
}

   
enum IAPStatus {
    case purchased
    case not
}

