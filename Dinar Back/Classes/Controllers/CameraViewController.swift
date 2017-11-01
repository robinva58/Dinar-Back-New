//
//  CameraViewController.swift
//  Dinar Back
//
//  Created by Madhup Yadav on 04/08/17.
//  Copyright © 2017 Jixtra Technologies LLP. All rights reserved.
//

import UIKit
import AVFoundation

protocol BarCodeResultDelegate: NSObjectProtocol {
    func captureBarCodeResult(barCodeString:String)
}

class CameraViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate,BarCodeResultDelegate {

    @IBOutlet weak var viewScannedProductDetails: UIView!
    @IBOutlet weak var verifyProductCameraOverlay: UIView!
    @IBOutlet weak var flashButton: UIButton!
    
    @IBOutlet weak var outputLabel: UILabel!
    var captureSession:AVCaptureSession!
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureDevice:AVCaptureDevice!
    public var delegate:BarCodeResultDelegate?
//    var qrCodeFrameView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeQRCode]
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            captureSession.startRunning()
            view.bringSubview(toFront: verifyProductCameraOverlay)
        } catch {
            logPrint(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination.isKind(of: UINavigationController.self)){
            let navigationController = segue.destination as! UINavigationController
            if let controller = navigationController.viewControllers.first as? BarCodeEnterViewController{
                controller.delegate = self
            }
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
        if metadataObjects == nil || metadataObjects.count == 0 {
            logPrint("No Code found!")
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode || metadataObj.type == AVMetadataObjectTypeEAN8Code || metadataObj.type == AVMetadataObjectTypeEAN13Code  {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            DispatchQueue.main.async {
                self.captureSession.stopRunning()
//                self.outputLabel.text = metadataObj.stringValue
            }
            let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                if self.delegate != nil{
                    self.delegate?.captureBarCodeResult(barCodeString: metadataObj.stringValue)
                }
                self.dismissView(nil)
            }
            logPrint(metadataObj.stringValue)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func dismissView(_ sender: UIButton?) {
        if (captureSession != nil && captureSession.isRunning){
            captureSession.stopRunning()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleFlash(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        do{
            if (captureDevice.hasTorch)
            {
                try captureDevice.lockForConfiguration()
                captureDevice.torchMode = sender.isSelected ? .on : .off
//                captureDevice.flashMode = sender.isSelected ? .on : .off
                captureDevice.unlockForConfiguration()
            }
        }catch{
            //DISABEL FLASH BUTTON HERE IF ERROR
            logPrint("Device tourch Flash Error ");
        }
    }
    
    @IBAction func helpButton(_ sender: UIButton) {
    }
    
    func captureBarCodeResult(barCodeString: String) {
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.delegate != nil{
                self.delegate?.captureBarCodeResult(barCodeString: barCodeString)
            }
            self.dismissView(nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
