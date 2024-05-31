//
//  IAPManager.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 5/27/24.
//

import Foundation
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
        
    var productIDS: [String] = [
//        "grandPiano69",
//        "acousticGuitarMajorChords",
//        "electronicKeyboard69",
//        "violin420"
        "com.wylan.apps.KnowNotes2024.guitar"
    ]
    
    
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

        func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
            for transaction in transactions {
                switch transaction.transactionState {
                case .purchased:
                    // Unlock content
                    print("Purchase successful: \(transaction.payment.productIdentifier)")
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

        func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
            // Handle completed restore transactions
            print("Restore transactions finished")
        }

        func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
            print("Restore failed: \(error.localizedDescription)")
        }
    
    
    
    }
    
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
   

