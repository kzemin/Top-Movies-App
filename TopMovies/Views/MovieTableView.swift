//
//  MovieTableView.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 27/10/2024.
//

import SwiftUI
import Combine

struct MovieTableView: UIViewRepresentable {
    @ObservedObject var viewModel: MoviesViewModel
    let onSelect: (Movie) -> Void
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = context.coordinator
        tableView.dataSource = context.coordinator
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        
        // Table view styling
        tableView.backgroundColor = UIColor(named: "pastelGreen") ?? .gray
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 110
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel, onSelect: onSelect)
    }
    
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        @ObservedObject var viewModel: MoviesViewModel
        var onSelect: (Movie) -> Void
        
        init(viewModel: MoviesViewModel, onSelect: @escaping (Movie) -> Void) {
            self.viewModel = viewModel
            self.onSelect = onSelect
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.movies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell ?? MovieCell(style: .default, reuseIdentifier: "MovieCell")
            let movie = viewModel.movies[indexPath.row]
            
            // Cell style
            cell.backgroundColor = UIColor.white
            cell.selectionStyle = .gray
            
            var content = cell.defaultContentConfiguration()
            
            // Text configuration
            content.text = movie.title
            content.secondaryText = movie.datePublished
            
            // Title configuration
            content.textProperties.font = .NetflixSansBold(size: 21)
            content.textProperties.color = UIColor(named: "darkGreen") ?? .black
            
            // Date configuration
            content.secondaryTextProperties.font = .NetflixSansLight(size: 15)
            content.secondaryTextProperties.color = UIColor(named: "grayGreen") ?? .gray
            
            // Spacing
            content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 85, bottom: 8, trailing: 16)
            content.textToSecondaryTextVerticalPadding = 4
            
            // Configure image separately
            cell.configure(with: movie)
            
            // Content configuration
            cell.contentConfiguration = content
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let movie = viewModel.movies[indexPath.row]
            onSelect(movie)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

class MovieCell: UITableViewCell {
    private var imageLoader = ImageLoader()
    private var movieImageView = UIImageView()
    var cancellables = Set<AnyCancellable>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        cancellables.removeAll()
    }
    
    private func setupViews() {
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieImageView.layer.cornerRadius = 5
        movieImageView.layer.masksToBounds = true
        
        addSubview(movieImageView)
        
        // Constrains for poster
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            movieImageView.widthAnchor.constraint(equalToConstant: 55),
            movieImageView.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // For image view staying above the content view
        bringSubviewToFront(movieImageView)
    }
    
    func configure(with movie: Movie) {
        movieImageView.image = UIImage(systemName: "photo")
        cancellables.removeAll()
        
        if let posterURL = movie.posterURL {
            print("Loading image from URL: \(posterURL)")
            imageLoader.loadImage(with: posterURL)
            imageLoader.$image
                .receive(on: DispatchQueue.main)
                .sink { [weak self] loadedImage in
                    if let image = loadedImage {
                        print("Image loaded successfully")
                        self?.movieImageView.image = image
                    } else {
                        print("Failed to load image")
                        self?.movieImageView.image = UIImage(systemName: "photo")
                    }
                }
                .store(in: &cancellables)
        }
    }
}

