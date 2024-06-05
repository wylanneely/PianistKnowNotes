//
//  InApPurchasePopUp.swift
//  KnowNotesPianist
//
//  Created by Wylan L Neely on 6/3/24.
//

import UIKit

class InApPurchasePopUp: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLanguageLocalizations()
        beginingStateConfig()
    }
    
    let InAppPurchaseManager = IAPManager.shared
    
    var instrument: InstrumentType = .BasicPiano
    
    let buyString:String =  NSLocalizedString("Buy",comment: "buy Purchase")
    let restoreString:String = NSLocalizedString("Restore",comment: "restore purchases")
    let grandPianoNotesString:String = NSLocalizedString("Grand Piano",comment: "grand piano")
    let acousticGuitarString:String = NSLocalizedString("Acoustic Guitar",comment: "acoustic guitar")
    let keyboardNotesString:String = NSLocalizedString("Keyboard", comment: "keyboard notes")
    let violinNotesString:String = NSLocalizedString("Violin", comment: "violin notes")

    let mediumHaptic = UIImpactFeedbackGenerator(style: .medium)

    //MARK: - SetUP
    
    init() {
        super.init(nibName: "InApPurchasePopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginingStateConfig(){
        self.view.alpha = 0
    }
    
    func setImagesLabels(instrumet:InstrumentType){
        self.instrument = instrumet
        productLabel.font = UIFont(name: "Poppins-Bold", size: 23)
        switch instrumet {
        case .BasicPiano:
            return
        case .GrandPiano:
            productLabel.text = grandPianoNotesString
            productImage.image = UIImage(named: "grandpiano")
        case .AcousticGuitar:
            productLabel.text = acousticGuitarString
            productImage.image = UIImage(named: "AcousticGuitar")
        case .Keyboard:
            productLabel.text = keyboardNotesString
            productImage.image = UIImage(named: "ElectricKeyboard")
        case .Violin:
            productLabel.text = violinNotesString
            productImage.image = UIImage(named: "violin")
        }
    }
    
    func setUpLanguageLocalizations(){
        var buyAttributes = AttributeContainer()
        buyAttributes.font = UIFont(name: "Helvetica Bold", size: 21)
        let buyTitle = AttributedString(buyString, attributes: buyAttributes)
        buyButton.configuration?.attributedTitle = buyTitle
        var restoreAttributes = AttributeContainer()
        restoreAttributes.font = UIFont(name: "Helvetica Bold", size: 18)
        let restoreTitle = AttributedString(restoreString, attributes: restoreAttributes)
        restoreButton.configuration?.attributedTitle = restoreTitle
    //    restoreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
      //  restoreButton.setTitle(restoreString, for: .normal)

    }
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    
    
    //MARK: - Actions
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        mediumHaptic.impactOccurred()
        switch instrument {
               case .BasicPiano:
                   break
               case .GrandPiano:
            let product = IAPManager.shared.getProductFrom(instrument: instrument)
                   IAPManager.shared.buyProduct(product)
               case .AcousticGuitar:
            let product = IAPManager.shared.getProductFrom(instrument: instrument)
                   IAPManager.shared.buyProduct(product)
               case .Keyboard:
            let product = IAPManager.shared.getProductFrom(instrument: instrument)
                   IAPManager.shared.buyProduct(product)
               case .Violin:
            let product = IAPManager.shared.getProductFrom(instrument: instrument)
                   IAPManager.shared.buyProduct(product)
               }
        self.hide()

    }
    
    
    @IBAction func retoreButtonTapped(_ sender: Any) {
        mediumHaptic.impactOccurred()
        IAPManager.shared.restoreProducts()
        self.hide()
    }
    
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        mediumHaptic.impactOccurred()
        self.hide()
    }
    
    //MARK: - Show
    
    func appear(sender: UIViewController,instrument:InstrumentType) {
        sender.present(self,animated: false){
            self.setImagesLabels(instrumet: instrument)
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.05) {
            self.view.alpha = 1
        }
    }
    
    //MARK: - Dismiss
    
    public func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.view.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }

}
