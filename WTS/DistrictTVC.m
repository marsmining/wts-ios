//
//  DistrictTVC.m
//  WTS
//
//  Created by foo on 9/20/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import "DistrictTVC.h"
#import "ImageVC.h"
#import "District+CD.h"
#import "Image+CD.h"

@interface DistrictTVC ()

@end

@implementation DistrictTVC

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
        
        District *district = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        if (district.images.count == 0) {
            return;
        }
        
        dlog(@"setting dvc model");
        ImageVC *ivc = (ImageVC *) dvc;
        ivc.path = [[district.images anyObject] path];
    }
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"District Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    District *district = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = district.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"images: %d", district.images.count];
    
    // use any old image for now
    if (district.images.count > 0) {
        Image *selectedImage = [district.images anyObject];
        NSURL *imgUrl = [Image getLocalUrlFromPathThumb:selectedImage.path];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        dlog(@"cell image view: %@", cell.imageView);
        cell.imageView.image = img;
    }
    
//    UIColor *bgcolor = [UIColor blackColor];
//    cell.contentView.backgroundColor = bgcolor;
//    cell.textLabel.backgroundColor = bgcolor;
//    cell.detailTextLabel.backgroundColor = bgcolor;
//    cell.accessoryView.backgroundColor = bgcolor;
//    cell.editingAccessoryView.backgroundColor = bgcolor;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dlog();
}

@end








