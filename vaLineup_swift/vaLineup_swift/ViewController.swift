//
//  ViewController.swift
//  vaLineup_swift
//
//  Created by Juan Carlos Hernández Cárdenas
//

import UIKit
import AVFoundation

enum NetworkError: Error{
    case badURL
    case decodingError
    case noData
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mapasLista = [Response]()
    var mapaDetalle : ResponseDetail?
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
                            
        if NetworkMonitor.shared.isConnected {
             print("You're connected")
        } else{
            showAlert()
        }
        
        playBackgroundMusic()

        let url = "https://private-2f576-valineupsapi.apiary-mock.com/org/org_list"
        getApiData(URL: url){ result in
            self.mapasLista = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func showAlert( ){
        let alert = UIAlertController(title: "Sin conexión a internet", message: "Por favor revise la conexión y reinicie la aplicación", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            exit(0)
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func getApiData(URL url:String, completion:@escaping ([Response]) -> Void){
        let url = URL(string:url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if data != nil && error == nil{
                do{
                    let parsingData = try JSONDecoder().decode([Response].self, from: data!)
                    completion(parsingData)
                }catch{
                    print("Error: \(error)")
                }
            }
        }
        dataTask.resume()
    }
    
    func getDetailApiData(URL url: String, completion:@escaping (ResponseDetail) -> Void){
        let url = URL(string:url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){ data, response, error in
            if data != nil && error == nil{
                do{
                    let parsingData = try JSONDecoder().decode(ResponseDetail.self, from: data!)
                    completion(parsingData)
                }catch{
                    print("Error: \(error)")
                }
            }
        }
        dataTask.resume()
    }
    
    
    func playBackgroundMusic(){
        guard let url = Bundle.main.url(forResource: "valsong", withExtension: ".mp3") else{
            print("No se encontró el archivo")
            return
        }
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 //para loopear la canción indefinidamente
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("Reproduciendo audio")
        }catch{
            print("Error al cargar el archivo de audio: \(error)")
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapasLista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.selectionStyle = .none
        cell.myLabel.text = mapasLista[indexPath.row].title
        imageDownloader.downloadImage(mapasLista[indexPath.row].thumbnail){ image, urlString in
            if let imageObject = image{
                DispatchQueue.main.async {
                    cell.myImageView.image = imageObject
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let dispatchGroup = DispatchGroup()
        let url =  "https://private-2f576-valineupsapi.apiary-mock.com/org/org_detail/" + mapasLista[indexPath.row].id
        dispatchGroup.enter()
        
        getDetailApiData(URL: url){ result in
            self.mapaDetalle = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetalleViewController") as? DetalleViewController {
                vc.detalleStruct = self.mapaDetalle
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
