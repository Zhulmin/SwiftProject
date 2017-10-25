//
//  MediaHandleController.swift
//  SwiftProject
//
//  Created by rain on 2017/10/20.
//  Copyright © 2017年 LoveRain. All rights reserved.
//



/**
    图片滤镜
    视频水印 ✘
    视频裁剪尺寸
    视频裁剪长度 ✘

 */


import UIKit
import AVKit
import EVGPUImage2
import Photos

class MediaHandleController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    
    var playerVc = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        playerVc = AVPlayerViewController()
        

    }
    
    
    @IBAction func startPlay(_ sender: Any) {
        
        let path = Bundle.main.path(forResource: "鹬.mp4", ofType: nil)!
        let videoUrl = URL(fileURLWithPath: path)
        
        let item = AVPlayerItem(url: videoUrl)
        let playlayer = AVPlayer(playerItem: item)
        
        playerVc.player = playlayer
        
        //        playlayer.replaceCurrentItem(with: nil)
        
        present(playerVc, animated: true, completion: nil)
        

    }
    
    
    // MARK: 使用GPUImage添加水印
    @IBAction func addWatermark(_ sender: Any) {
        
        
        let filter = NormalBlend()
//        filter.
        
        let path = Bundle.main.path(forResource: "鹬.mp4", ofType: nil)
        let videoUrl = URL(fileURLWithPath: path!)
        let asset = AVAsset(url: videoUrl)
//        let size = asset.naturalSize  // unusable in swift
        do {
            let moviewInput = try MovieInput.init(asset: asset)
//            movieInput.playAtActualSpeed = false
            
            // you can create any view with subclass view
            
            // add label watermark
            
            let label = UILabel()
            label.text = "maked by rain"
            
            
            
            
        } catch {
//            print "create camera failure.. may no authed"
            print(error)
            return
        }
        
        
        
//        GPUImageUIElement
        /**
         使用GPUImage加载水印
         
         @param vedioPath 视频路径
         @param img 水印图片
         @param coverImg 水印图片二
         @param question 字符串水印
         @param fileName 生成之后的视频名字
         */
//        -(void)saveVedioPath:(NSURL*)vedioPath WithWaterImg:(UIImage*)img WithCoverImage:(UIImage*)coverImg WithQustion:(NSString*)question WithFileName:(NSString*)fileName
//        {
//            [SVProgressHUD showWithStatus:@"生成水印视频到系统相册"];
//
//            filter = [[GPUImageNormalBlendFilter alloc] init];
//
//            GPUImageUIElement *uielement = [[GPUImageUIElement alloc] initWithView:subView];
//            NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.mp4",fileName]];
//            unlink([pathToMovie UTF8String]);
//            NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
//
//            movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(720.0, 1280.0)];
//
//            GPUImageFilter* progressFilter = [[GPUImageFilter alloc] init];
//            [progressFilter addTarget:filter];
//            [movieFile addTarget:progressFilter];
//            [uielement addTarget:filter];
//            movieWriter.shouldPassthroughAudio = YES;
//            //    movieFile.playAtActualSpeed = true;
//            if ([[asset tracksWithMediaType:AVMediaTypeAudio] count] > 0){
//                movieFile.audioEncodingTarget = movieWriter;
//            } else {//no audio
//                movieFile.audioEncodingTarget = nil;
//            }
//            [movieFile enableSynchronizedEncodingUsingMovieWriter:movieWriter];
//            // 显示到界面
//            [filter addTarget:movieWriter];
//
//            [movieWriter startRecording];
//            [movieFile startProcessing];
//
//            //    dlink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
//            //    [dlink setFrameInterval:15];
//            //    [dlink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//            //    [dlink setPaused:NO];
//
//            __weak typeof(self) weakSelf = self;
//            //渲染
//            [progressFilter setFrameProcessingCompletionBlock:^(GPUImageOutput *output, CMTime time) {
//                //水印可以移动
//                CGRect frame = coverImageView1.frame;
//                frame.origin.x += 1;
//                frame.origin.y += 1;
//                coverImageView1.frame = frame;
//                //第5秒之后隐藏coverImageView2
//                if (time.value/time.timescale>=5.0) {
//                [coverImageView2 removeFromSuperview];
//                }
//                [uielement update];
//
//                }];
//            //保存相册
//            [movieWriter setCompletionBlock:^{
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                __strong typeof(self) strongSelf = weakSelf;
//                [strongSelf->filter removeTarget:strongSelf->movieWriter];
//                [strongSelf->movieWriter finishRecording];
//                __block PHObjectPlaceholder *placeholder;
//                if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie))
//                {
//                NSError *error;
//                [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//                PHAssetChangeRequest* createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:movieURL];
//                placeholder = [createAssetRequest placeholderForCreatedAsset];
//                } error:&error];
//                if (error) {
//                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
//                }
//                else{
//                [SVProgressHUD showSuccessWithStatus:@"视频已经保存到相册"];
//                }
//                }
//                });
//                }];
//        }
//
//
//    }
    
    }
        
    
    func imageFilter() {
        
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3.0) {
        //
        //
        //            // image signal filter
        //
        //            let brightness = BrightnessAdjustment()
        //            brightness.brightness = 0.3
        //
        //            let image = self.pictureImageView.image?.filterWithOperation(brightness)
        //
        //            self.pictureImageView.image = image;
        //        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3.0) {
            
            // image multi-filter
            
            let exp = ExposureAdjustment()
            exp.exposure = 0.2
            let gamma = GammaAdjustment()
            gamma.gamma = 0.3
            
            let image = self.pictureImageView.image?.filterWithPipeline({ (input, output) in
                input-->exp-->gamma-->output
            })
            
            self.pictureImageView.image = image
            
        }
        
    }

}
