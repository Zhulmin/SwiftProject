//
//  GPUCameraController.swift
//  SwiftProject
//
//  Created by rain on 2017/10/24.
//  Copyright © 2017年 LoveRain. All rights reserved.
//

import UIKit
import EVGPUImage2
import AVKit
import Photos

/**
 
 视频处理, 录制视频 - 实时滤镜
 */


class GPUCameraController: UIViewController {
    
    
    @IBAction func recordVideoWithFilter(_ button: UIButton) {
        
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            button.setTitle("点击停止录制", for: .selected)
            startRecord()
        }else {
            button.setTitle("点击开始录制", for: .normal)
        }
    }
    
    func startRecord() {
        
        var camera : Camera?
        
        do {
            camera = try Camera(sessionPreset:AVCaptureSessionPreset640x480)
            
        } catch {
            print("create camera object failuer")
        }
        
        
        let operation = SobelEdgeDetection()
        operation.edgeStrength = 0.5
        // 创建一个RenderView的实例并添加到view上，用来显示最终处理出的内容
        let renderView = RenderView(frame: self.view.bounds)
        self.view.addSubview(renderView)
        
        // 绑定处理链
        camera! --> operation --> renderView
        
        // 开始捕捉数据
        camera!.startCapture()
        
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask  , true).last!
        let uuid = UUID().uuidString
        path.append("/\(uuid).mp4")
        let url = URL(fileURLWithPath: path)
        
        do {
            let output = try MovieOutput(URL: url, size: Size(width: 480, height: 640), fileType: AVFileTypeQuickTimeMovie, liveVideo: true, settings: nil)
            
            operation.addTarget(output)
            camera?.audioEncodingTarget = output
            output.startRecording()
            
            // MARK: 结束录制
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.0) {
                operation.removeAllTargets()
                camera?.audioEncodingTarget = nil
                output.finishRecording()
                
                
                
                PHPhotoLibrary.shared().performChanges({
                    
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                }) { saved, error in
                    if saved {
                        let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else {
                        print(error ?? "")
                    }
                }
                
                
//                UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(self.imagePickerController(_:didFinishPickingMediaWithInfo:)), nil)
            }
            
        } catch {
            print("create output object failuer")
        }
    }
    
    
    func finish() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask  , true).last!
//        path.append("/one.mp4")
//        let fileManager = FileManager()
//
//        let url = URL(fileURLWithPath: path)
    }
    
    // Do any additional setup after loading the view.
    
}
