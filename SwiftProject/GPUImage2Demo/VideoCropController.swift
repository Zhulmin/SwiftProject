//
//  VideoCropController.swift
//  SwiftProject
//
//  Created by rain on 2017/10/25.
//  Copyright © 2017年 LoveRain. All rights reserved.
//

import UIKit
import Photos
import EVGPUImage2

/**
 
 没有使用renderView 做本地视频渲染
 */

class VideoCropController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cropVideo(_ sender: Any) {
        
        
        let sourcePath = Bundle.main.path(forResource: "鹬.mp4", ofType: nil)!
        let videoUrl = URL(fileURLWithPath: sourcePath)
        
        
        var outputPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask  , true).last!
        let uuid = UUID().uuidString
        outputPath.append("/\(uuid).mp4")
        let outputUrl = URL(fileURLWithPath: outputPath)
        
        
        let crop = Crop()
        let size = Size.init(width: 960, height: 200)
        crop.cropSizeInPixels = size
        crop.locationOfCropInPixels = Position.init(0, 0)
        
        let input = try?  MovieInput(url: videoUrl)
        
        let output = try? MovieOutput(URL: outputUrl, size: size, fileType: AVFileTypeQuickTimeMovie, liveVideo: false, settings: nil)
        
        guard let _output = output else {
            return
        }
        guard let _input = input else {
            return
        }
        _input --> crop --> _output
//        _input.runBenchmark
        _input.addTarget(crop)
        crop.addTarget(_output)
        
        _output.startRecording()
        _input.start()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()  + 20) {
            
            _output.finishRecording {
                
                _input.removeAllTargets()
                crop.removeAllTargets()
                
                PHPhotoLibrary.shared().performChanges({
                    
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputUrl)
                    
                }) { saved, error in
                    if saved {
                        let alertController = UIAlertController(title: "视频裁剪完成!", message: nil, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else {
                        print(error!)
                        print("\n\n\n 错误 \n\n\n")
                    }
                }
            }
        }
    }
}

