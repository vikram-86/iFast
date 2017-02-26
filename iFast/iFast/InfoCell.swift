//
//  InfoCell.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 24.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

//MARK: InfoCelViewModel
struct InfoCellViewModel{

  let title						: String
  let image						: UIImage
  let contentFilePath	: String

  init(title: String, image: UIImage, contentFilePath: String = ""){
    self.title = title
    self.image = image
    self.contentFilePath = contentFilePath
  }
}

//MARK: InfoCell
class InfoCell: UITableViewCell {

  //MARK: IBOutlets
  @IBOutlet weak var headerImage	: UIImageView!
  @IBOutlet weak var titleLabel		: UILabel!


  func configureCell(with viewModel: InfoCellViewModel){
    titleLabel.text 	= viewModel.title
    headerImage.image	= viewModel.image
  }
  
}
