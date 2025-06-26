import UIKit
import AVKit

class ViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "万能流媒体播放器"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let urlTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入流媒体URL (如 m3u8/mp4/rtmp)"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶️ 播放", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var playerViewController: AVPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(urlTextField)
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            urlTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            urlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            urlTextField.heightAnchor.constraint(equalToConstant: 44),
            
            playButton.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 30),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            playButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        playButton.addTarget(self, action: #selector(playStream), for: .touchUpInside)
    }
    
    @objc private func playStream() {
        guard let urlString = urlTextField.text, let url = URL(string: urlString), !urlString.isEmpty else {
            let alert = UIAlertController(title: "错误", message: "请输入有效的流媒体URL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default))
            present(alert, animated: true)
            return
        }
        let player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player
        present(playerViewController!, animated: true) {
            player.play()
        }
    }
} 