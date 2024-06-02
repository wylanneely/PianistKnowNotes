//
//  IAPManager.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 5/27/24.
//

import Foundation
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //Availible
    public var grandPianoStatus: IAPStatus = .not
    public var guitarMajorChords: IAPStatus = .not
    public var keyboard: IAPStatus = .not
    public var violin: IAPStatus = .not
    
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
    
    
    static let shared = IAPManager()
    private override init() {}
    
    var productsRequest: SKProductsRequest!
    var availableProducts = [SKProduct]()
    
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
    
    func storePurchases(transaction:SKPaymentTransaction){
        
        let  productID = transaction.payment.productIdentifier
            print(productID)
        //add switch on product identifier
        
            
        
    
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
}
//
//    public func processReceipt() -> Bool {
//            print("receiptValidationStarted")
//            
//            receipt = IAPReceipt()
//
//            guard receipt.isReachable,
//                  receipt.load(),
//                  receipt.validateSigning(),
//                  receipt.read(),
//                  receipt.validate() else {
//
//                print("receiptProcessingFailure")
//                return false
//            }
//
//            createValidatedPurchasedProductIds(receipt: receipt)
//            print("receiptProcessingSuccess")
//            return true
//        }
//
//        func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
//            // Handle completed restore transactions
//            print("Restore transactions finished")
//        }
//
//        func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
//            print("Restore failed: \(error.localizedDescription)")
//        }
//    
//    
//    
      
    
//    // Keep a strong reference to the product request.
//    var request: SKProductsRequest!
//
//    func validate(productIdentifiers: [String]) {
//         let productIdentifiers = Set(productIdentifiers)
//
//        
//         request = SKProductsRequest(productIdentifiers: productIdentifiers)
//         request.delegate = self
//         request.start()
//    }
//
//
//    var products = [SKProduct]()
//    // Create the SKProductsRequestDelegate protocol method
//    // to receive the array of products.
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        if !response.products.isEmpty {
//           products = response.products
//           // Implement your custom method here.
//         //  displayStore(products)
//        }
//
//
//        for invalidIdentifier in response.invalidProductIdentifiers {
//           // Handle any invalid product identifiers as appropriate.
//        }
//    }
//    
   
enum IAPStatus {
    case purchased
    case not
}

