//
//  DistrictTVC.m
//  WTS
//
//  Created by foo on 9/20/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "DistrictTVC.h"
#import "ImageVC.h"
#import "District.h"

@interface DistrictTVC ()

@end

@implementation DistrictTVC

@synthesize districts = _districts;

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)back:(id)sender
{
    dlog();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    dlog(@"segue: %@", [segue identifier]);
        
    id dvc = [segue destinationViewController];    
    if ([dvc isKindOfClass:[ImageVC class]]) {
        
        UITableViewCell *cell = (UITableViewCell *) sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        District *district = self.districts[indexPath.row];
        
        if (district.images.count == 0) {
            return;
        }
        
        dlog(@"setting dvc model");
        ImageVC *ivc = (ImageVC *) dvc;
        ivc.path = [[district.images anyObject] path];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    dlog();
    return self.districts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"District Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    District *district = self.districts[indexPath.row];
    
    cell.textLabel.text = district.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"images: %d", district.images.count];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dlog();
}

@end
