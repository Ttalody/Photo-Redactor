//
//  HomeViewController.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

class HomeViewController: UIViewController {
    private enum Constants {
        enum Icon {
            static let plusIconImage = UIImage(systemName: "plus")
            static let saveIconImage = UIImage(systemName: "arrowshape.down.circle")
        }
        
        enum CropView {
            static let borderWidth: CGFloat = 2
            static let borderColor: CGColor = UIColor.yellow.cgColor
            static let width: CGFloat = 300
            static let height: CGFloat = 500
        }
        
        enum Titles {
            static let selectPhoto = "Select photo"
            static let save = "Save"
            static let original = "Original"
            static let blackAndWhite = "Black-and-white"
        }
    }
    
    // MARK: - Properties
    private var viewModel: HomeViewModel
    
    // MARK: - Components
    private lazy var selectedImageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var initialStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = Grid.Spacing.s
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var initialViewTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = Constants.Titles.selectPhoto
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.Icon.plusIconImage, for: .normal)
        button.addTarget(self, action: #selector(addPhotoAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Titles.save, for: .normal)
        button.setImage(Constants.Icon.saveIconImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var cropAreaView: UIView = {
        let view = UIView()
        view.layer.borderWidth = Constants.CropView.borderWidth
        view.layer.borderColor = Constants.CropView.borderColor
        view.backgroundColor = .clear
        return view
    }()
    
    private let imageStyleSegmentedConrtol: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: Constants.Titles.original, at: .zero, animated: true)
        segmentedControl.insertSegment(withTitle: Constants.Titles.blackAndWhite, at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = .zero
        segmentedControl.addTarget(self, action: #selector(segmentDidChange), for: .valueChanged)
        return segmentedControl
    }()
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        DispatchQueue.main.async { [weak self] in
            self?.setupGestures()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        selectedImageImageView.layoutIfNeeded()
        cropAreaView.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMask()
    }
}

// MARK: - Private methods
private extension HomeViewController {
    
    // MARK: - Setup Views
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(initialStackView)
        
        setupInitialView()
        setupCropAreaView()
        setupSelectedImageImageView()
        setupImageStyleSegmentedConrtol()
    }
    
    func setupBindings() {
        viewModel.didUpdateImage = { [weak self] in
            self?.initialStackView.isHidden = true
            self?.imageStyleSegmentedConrtol.isHidden = false
            self?.cropAreaView.isHidden = false
            self?.selectedImageImageView.isHidden = false
            self?.selectedImageImageView.image = self?.viewModel.getImage()
        }
        
        viewModel.filteredImage = { [weak self] image in
            self?.selectedImageImageView.image = image
        }
    }
    
    func setupInitialView() {
        initialStackView.isHidden = false
        initialStackView.addArrangedSubview(initialViewTitle)
        initialStackView.addArrangedSubview(plusButton)
        
        initialStackView.translatesAutoresizingMaskIntoConstraints = false
        let vertical = initialStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let leading = initialStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = initialStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([vertical, leading, trailing])
    }
    
    func setupImageStyleSegmentedConrtol() {
        view.addSubview(imageStyleSegmentedConrtol)
        
        imageStyleSegmentedConrtol.isHidden = true
        imageStyleSegmentedConrtol.translatesAutoresizingMaskIntoConstraints = false
        
        let bottom = imageStyleSegmentedConrtol.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Grid.Spacing.m)
        let horizontal = imageStyleSegmentedConrtol.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([bottom, horizontal])
    }
    
    func setupSelectedImageImageView() {
        cropAreaView.addSubview(selectedImageImageView)
        
        selectedImageImageView.isHidden = true
        selectedImageImageView.isUserInteractionEnabled = true
        selectedImageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let vertical = selectedImageImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let horizontal = selectedImageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let width = selectedImageImageView.widthAnchor.constraint(equalToConstant: view.bounds.width)
        let height = selectedImageImageView.heightAnchor.constraint(equalToConstant: view.bounds.height)
        NSLayoutConstraint.activate([vertical, horizontal, width, height])
    }
    
    func setupCropAreaView() {
        view.addSubview(cropAreaView)
        
        cropAreaView.isHidden = true
        cropAreaView.clipsToBounds = true
        cropAreaView.isUserInteractionEnabled = true
        cropAreaView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontal = cropAreaView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertical = cropAreaView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let width = cropAreaView.widthAnchor.constraint(equalToConstant: Constants.CropView.width)
        let height = cropAreaView.heightAnchor.constraint(equalToConstant: Constants.CropView.height)
        NSLayoutConstraint.activate([vertical, horizontal, width, height])
        
    }
    
    func setupMask() {
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: cropAreaView.bounds)
        maskLayer.path = path.cgPath
        
        cropAreaView.layer.mask = maskLayer
    }
    
    // MARK: - Setup Gertures
    func setupGestures() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        selectedImageImageView.addGestureRecognizer(pinchGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        selectedImageImageView.addGestureRecognizer(panGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture(_:)))
        selectedImageImageView.addGestureRecognizer(rotationGesture)
    }
    
    @objc
    func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1.0
    }
    
    @objc
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        gesture.view?.center = CGPoint(
            x: gesture.view!.center.x + translation.x,
            y: gesture.view!.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
    }
    
    @objc
    func handleRotationGesture(_ gesture: UIRotationGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.rotated(by: gesture.rotation)
        gesture.rotation = .zero
    }
    
    // MARK: - Button Actions
    @objc
    func saveAction() {
        
    }
    
    @objc
    func addPhotoAction() {
        viewModel.requestPhotoLibraryAccess(from: self)
    }
    
    @objc
    func segmentDidChange() {
        viewModel.applyFilter(option: imageStyleSegmentedConrtol.selectedSegmentIndex)
    }
    
    // MARK: - Setup NavigationBar
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .secondarySystemBackground
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let saveBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.rightBarButtonItems?.append(saveBarButtonItem)
    }
}

