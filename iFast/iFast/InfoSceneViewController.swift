//
//  InfoSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 24.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol InfoSceneViewControllerInput
{
  
}

protocol InfoSceneViewControllerOutput
{

}

class InfoSceneViewController: UIViewController, InfoSceneViewControllerInput
{
  var output: InfoSceneViewControllerOutput!
  var router: InfoSceneRouter!
  var viewController : InfoSceneViewController? {
    let storyboard = UIStoryboard(name: String.init(describing: self), bundle: nil)
    return storyboard.instantiateInitialViewController() as? InfoSceneViewController
  }

  var dataSource: [InfoCellViewModel] {
    return [howToIFVM, quickGuideVM]
  }
  var selectedCell: InfoCellViewModel!

  fileprivate let cellIdentifier = "infoCell"

  //MARK: IBOUtlets
  @IBOutlet weak var tableView: UITableView!

  // MARK: - Object lifecycle
  override func awakeFromNib()
  {
    super.awakeFromNib()
    InfoSceneConfigurator.sharedInstance.configure(viewController: self)
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    tableView.dataSource 	= self
    tableView.delegate		= self

  }
}

//MARK: - Display Logic -
extension InfoSceneViewController {

}

// MARK: - Event Handler - 
extension InfoSceneViewController {

  @IBAction func closeButtonPressed(){
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - UITableView datasource & delegate
extension InfoSceneViewController: UITableViewDataSource, UITableViewDelegate{

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? InfoCell else {
      return InfoCell()
    }

    cell.configureCell(with: dataSource[indexPath.row])
    cell.selectionStyle = .none
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedCell = dataSource[indexPath.row]
    performSegue(withIdentifier: InfoSceneRouter.SegueIdentifiers.infoDetail.rawValue, sender: nil)
  }
}
