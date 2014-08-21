//
//  ESMenuTableViewController.swift
//  TaxiEmpresarial
//
//  Created by Erick Iglesias on 19/08/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//
import UIKit
import Foundation


class ESMenuTableViewController : UITableViewController {
    
   
    
    var contentList:NSMutableArray
    var menuMyAccount:NSArray = []
    var menuGeneral:NSArray
    var menuImage:UIImage
    var nombreStr:NSString
    var sectionIdentifier:NSArray
    var arrayMenu:NSMutableArray
    var array:NSMutableArray
    @IBOutlet var menuTableView:UITableView!
    
    
    override func viewDidLoad() {
        [super.viewDidLoad];
        var insent:UIEdgeInsets = UIEdgeInsetsMake(27, 0, 0, 0)
        menuTableView.contentInset = insent
        menuGeneral = ["miPerfil","salir"]
        menuMyAccount = ["inicio","tarifas","ayuda"]
        let firstSection:NSArray = [NSLocalizedString("MiPerfil", nil), NSLocalizedString("Mis Reservaciones", nil),NSLocalizedString("Salir", nil), nil]
        let secondSection:NSArray = [NSLocalizedString("Inicio", nil), NSLocalizedString("Ayuda", nil), nil]
        arrayMenu = [menuMyAccount,menuGeneral, nil];
        array = [firstSection, secondSection, nil];
        [self.setContentsList: arrayMenu]
    }
    
    init(frame: CGRect, style Plain: UITableViewStyle)
    

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: sender!) {
        
        if (segue.isKindOfClass(SWRevealViewControllerSegue))
        {
            var rvcs:SWRevealViewControllerSegue = segue as SWRevealViewControllerSegue
            var rvc:SWRevealViewController = self.revealViewController()
            
            NSAssert( rvc != nil,"oops! must have a revealViewController")
            var rvc_segue:SWRevealViewControllerSegue
            var svc:UIViewController
            var dvc:UIViewController
            rvcs.performBlock = {(rvc_segue, svc, dvc) in
                if (segue.identifier = "logout"){
                    FBSession.closeAndClearTokenInformation(FBSession)
                    let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    userDefaults.removeObjectForKey(KEY_FB_LOGIN)
                    userDefaults.synchronize()
                    GPPSignIn.signOut()
                }
                var nc:UINavigationController = dvc as UINavigationController
                rvc.pushFrontViewController(nc, animated: true)
            }
        }
// MARK: - UITableViewDataSource Methods
        override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
            section = contentList.count
            
            return section
        }
        override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
            sectionIdentifier = contentList.objectAtIndex(section)
        }
        
        override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
            
            
            sectionIdentifier = contentList.objectAtIndex(indexPath.section)
            
            let CellIdentifier:NSString = sectionIdentifier.objectAtIndex(indexPath.row)
            let sectionTitles:NSArray = array.objectAtIndex(indexPath.section)
            let titleForThisRow:NSString = sectionTitles.objectAtIndex(indexPath.row)
            
            var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath)
            /*
            if (cell == nil)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]
            }
            UIImageView *imageView = nil;
            UILabel *nombreLbl = nil;
            imageView = (UIImageView *)[cell viewWithTag:1];
            nombreLbl = (UILabel *)[cell viewWithTag:2];
            [nombreLbl setFont:[UIFont fontWithName:@"TrebuchetMS" size:15]];
            [nombreLbl setText:titleForThisRow];
            [imageView setImage:[UIImage imageNamed:CellIdentifier]];
            
            let CellID: NSString = "Cell"
            var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellID) as? UITableViewCell
            if !cell {
                cell = UITableViewCell(style: .Default, reuseIdentifier: CellID)
            }
            cell!.textLabel.text = self.names[indexPath.row] as NSString
            return cell
        }
*/
        
        override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
            let detailsController: PeopleDetailsViewController = PeopleDetailsViewController(style: .Grouped)
            detailsController.details = self.data[indexPath.row] as NSDictionary
            self.navigationController!.pushViewController(detailsController, animated: true)
        }
    }
}