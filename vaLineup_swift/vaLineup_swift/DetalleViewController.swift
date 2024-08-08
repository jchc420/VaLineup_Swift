//
//  DetalleViewController.swift
//  vaLineup_swift
//
//  Created by Juan Carlos Hernández Cárdenas
//

import YouTubeiOSPlayerHelper
import UIKit

class DetalleViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet var playerView: YTPlayerView!
    
    @IBOutlet weak var personajeTF: UITextField!
    
    var personajes = ["Sova", "KAYO", "Gekko", "Viper", "Killjoy","Fade","Brimstone"]
    let pickerView = UIPickerView()
    
    var detalleStruct : ResponseDetail?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //para el pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        personajeTF.inputView = pickerView
        
        //para el youtube player
        playerView.delegate = self
        
        playerView.isHidden = true
        
        labelName.text = detalleStruct?.title
        var imageURL = detalleStruct?.image ?? " "
        imageDownloader.downloadImage(imageURL){ image, urlString in
            if let imageObject = image{
                DispatchQueue.main.async {
                    self.imgView.image = imageObject
                }
            }
        }
        
    }
}

extension DetalleViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return personajes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return personajes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        personajeTF.text = personajes[row]
        personajeTF.resignFirstResponder()
        if personajeTF.text == "Sova" {
            playerView.isHidden = false
            playerView.load(withVideoId: detalleStruct?.sovaLineup ?? " ")
            playerView.playVideo()
        } else if personajeTF.text == "KAYO"{
            playerView.isHidden = false
            playerView.load(withVideoId: detalleStruct?.kayoLineup ?? " ")
            playerView.playVideo()
        }else if personajeTF.text == "Gekko"{
            playerView.isHidden = false
            playerView.load(withVideoId: detalleStruct?.gekkoLineup ?? " ")
            playerView.playVideo()
        }else if personajeTF.text == "Viper"{
            playerView.isHidden = false
            playerView.load(withVideoId: detalleStruct?.viperLineup ?? " ")
            playerView.playVideo()
        }else if personajeTF.text == "Killjoy"{
            playerView.isHidden = false
            playerView.load(withVideoId: detalleStruct?.kjLineup ?? " ")
            playerView.playVideo()
        }else if personajeTF.text == "Fade"{
            playerView.isHidden = false
            playerView.load(withVideoId: detalleStruct?.fadeLineup ?? " ")
            playerView.playVideo()
        } else if personajeTF.text == "Brimstone"{
            playerView.isHidden = false
            playerView.load(withVideoId: detalleStruct?.brimLineup ?? " ")
            playerView.playVideo()
        }
    }
    
    
}
