//
//  ViewController.swift
//  ClassQuote
//
//  Created by HAMDI TLILI on 09/05/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var newQuoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private func addShadowToQuoteLabel() {
        quoteLabel.layer.shadowColor = UIColor.black.cgColor
        quoteLabel.layer.shadowOpacity = 0.9
        quoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    private func update(quote: Quote) {
        quoteLabel.text = quote.text
        authorLabel.text = quote.autor
        imageView.image = UIImage(data: quote.imageData)
    }
    private func prentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The quote download faild", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func tappedNewQuoteButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        QuoteService.shared.getQuote {success,quote in
            self.toggleActivityIndicator(shown: false)
            guard let quote = quote, success == true else {
                // Afficher le message d'erreur
                self.prentAlert()
                return
            }
            self.update(quote: quote)
            // afficher la citation
        }
    }
    private func toggleActivityIndicator(shown: Bool) {
        newQuoteButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
}

