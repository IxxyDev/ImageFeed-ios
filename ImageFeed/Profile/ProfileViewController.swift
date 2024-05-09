import UIKit

final class ProfileViewController: UIViewController {
    private var profileImage: UIImageView {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "avatar")
        profileImage.clipsToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImage)
        
        profileImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        return profileImage
    }
    
    private var nameLabel: UILabel {
        let label = UILabel()
        label.text = "Jane Doe"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        return label
    }

    private var usernameLabel: UILabel {
        let label = UILabel()
        label.text = "@jane_doe"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        return label
    }
    
    private var textLabel: UILabel {
        let label = UILabel()
        label.text = "Hello, world!"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        return label
    }
    
    private var logoutButton: UIButton {
        let button = UIButton.systemButton(
            with: UIImage(named: "logout_button") ?? UIImage(),
            target: self,
            action: #selector(Self.didTapLogoutButton))
        button.tintColor = UIColor(named: "YP_Red")
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true
        button.leadingAnchor.constraint(greaterThanOrEqualTo: profileImage.trailingAnchor).isActive = true
        
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlack
        profileImage.isHidden = false
        nameLabel.isHidden = false
        usernameLabel.isHidden = false
        textLabel.isHidden = false
        logoutButton.isHidden = false
    }
    
    @objc private func didTapLogoutButton() {
        print("Tapped Log Out")
    }
}
