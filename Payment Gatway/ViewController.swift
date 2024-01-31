//
//  ViewController.swift
//  Payment Gatway
//
//  Created by Awadhesh Pratap Singh on 02/01/24.
//

import UIKit
import Razorpay

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    var rozarPayKey = "rzp_test_tF969X6Y74fYjS"
    var razorPay: RazorpayCheckout? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.9  // Set the shadow opacity here
        mainView.layer.shadowOffset = CGSize(width: 5, height: 5)
        mainView.layer.shadowRadius = 10
    }

    @IBAction func buyNowButton(_ sender: UIButton) {
        self.showPaymentForm()
    }

    internal func showPaymentForm(){
        razorPay = RazorpayCheckout.initWithKey(rozarPayKey, andDelegate: self)
        let options: [String:Any] = [
                    "amount": "100", //This is in currency subunits. 100 = 100 paise= INR 1.
                    "currency": "INR",//We support more that 92 international currencies.
                    "description": "Are you sure, you want to pay!",
                    "image": "https://cdn.vectorstock.com/i/1000x1000/07/08/aps-monogram-logo-vector-44760708.webp",
                    "name": "APS Electronics",
                    "prefill": [
                        "contact": "9797979797",
                        "email": "APS.electronics.com"
                    ],
                    "theme": [
                        "color": "#F37254"
                    ]
                ]
//        razorpay.open(options)
        razorPay?.open(options)
    }

}

extension ViewController: RazorpayPaymentCompletionProtocol{
    
    func onPaymentError(_ code: Int32, description str: String) {
        presentAlert(withTitle: "Failed", message: """

            \(str)
            """)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        presentAlert(withTitle: "Success", message: """
            
            Payment Successful
            """)
    }
    
    func presentAlert(withTitle title: String?, message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let Done  = UIAlertAction(title: "Done", style: .cancel, handler: nil)
            alert.addAction(Done)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

