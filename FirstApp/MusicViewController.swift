//
//  MusicViewController.swift
//  FirstApp
//
//  Created by Emma Barme on 08/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {

    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        //1 You need to know the full path to the sound file, and NSBundle.mainBundle() will tell you where in the project to look. AVAudioPlayer needs to know the path in the form of a URL, so the full path is converted to URL format.
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        //2 A NSError object will store an error message if something goes wrong when setting up the AVAudioPlayer. Usually nothing will go wrong, but it’s always good practice to check for errors, just in case!
        var error: NSError?
        
        //3 This is the important call to set up AVAudioPlayer. You’re passing in the URL, and the error will get filled in if something goes wrong
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        //4 If all goes well, the AVAudioPlayer object will be returned!
        return audioPlayer!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicPlayers["Unicorn"] = AVAudioPlayer()
        musicPlayers["Unicorn"] = self.setupAudioPlayerWithFile("PinkFluffyUnicornsMusic", type:"mp3")
        musicPlayers["Dion"] = AVAudioPlayer()
        musicPlayers["Dion"] = self.setupAudioPlayerWithFile("CelineDion", type:"mp3")
        musicPlayers["DeGaulle"] = AVAudioPlayer()
        musicPlayers["DeGaulle"] = self.setupAudioPlayerWithFile("DeGaulle", type:"mp3")
        musicPlayers["KingLouis"] = AVAudioPlayer()
        musicPlayers["KingLouis"] = self.setupAudioPlayerWithFile("KingLouisSong", type:"mp3")
        musicPlayers["NyanCat"] = AVAudioPlayer()
        musicPlayers["NyanCat"] = self.setupAudioPlayerWithFile("NyanCat", type:"mp3")
        musicPlayers["Marche"] = AVAudioPlayer()
        musicPlayers["Marche"] = self.setupAudioPlayerWithFile("MarcheImperiale", type:"mp3")
        
    }
    
    var musicPlayers = [String: AVAudioPlayer]()
    var currentPlayer: AVAudioPlayer?
    
    @IBAction func chooseMusic(sender: UIButton) {
        if let name = sender.currentTitle {
            currentPlayer = musicPlayers[name]
            if currentPlayer != nil {
                currentPlayer?.prepareToPlay()
            }
        }
    }
    
    @IBAction func musicButtons(sender: UIButton) {
        if let musicPlayer = currentPlayer {
            let buttonText = sender.titleLabel?.text
            switch buttonText! {
            case "▶︎":
                musicPlayer.play()
            case "ll":
                musicPlayer.pause()
            case "◼︎":
                musicPlayer.stop()
                musicPlayer.currentTime = 0
            default:
            break
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
