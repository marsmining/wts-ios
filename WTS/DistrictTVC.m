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
#import "DistrictTableCell.h"

static NSString *CellIdentifier = @"DistrictTableCell";

@interface DistrictTVC ()
@property (nonatomic, strong) UINib *nibForCell;
@end

@implementation DistrictTVC

- (UINib *) nibForCell {
    if (!_nibForCell) {
        _nibForCell = [UINib nibWithNibName:CellIdentifier bundle:[NSBundle mainBundle]];
        dlog(@"uinib: %@", [_nibForCell instantiateWithOwner:self options:nil]);
    }
    return _nibForCell;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 77.0;

    // background of table view
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"45degreee_fabric.gif"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:self.nibForCell forCellReuseIdentifier:CellIdentifier];
}

- (IBAction)back:(id)sender
{
    dlog();
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

//- (NSString *) trimLeadingBy:(NSUInteger) trimAmt fromString:(NSString *) name {
//    if (name.length > trimAmt)
//        return [name substringFromIndex:trimAmt];
//    else return name;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	return [self trimLeadingBy: 7 fromString:
//            [[[self.fetchedResultsController sections] objectAtIndex:section] name]];
//}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DistrictTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                         forIndexPath:indexPath];
    
    District *district = [self.fetchedResultsController objectAtIndexPath:indexPath];

    // use any old image for now
    if (cell.thumb.image == nil && district.images.count > 0) {
        Image *selectedImage = [district.images anyObject];
        NSURL *imgUrl = [Image getLocalUrlFromPathThumb:selectedImage.path];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        cell.thumb.image = img;
    }

    cell.title.text = district.name;
    cell.subtitle.text = [NSString stringWithFormat:@"image count: %d", district.images.count];
    return cell;
}

#pragma mark - Table view delegate

//
// district selected, so grab array of paths and give to controller.
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dlog();
    
    District *district = [self.fetchedResultsController objectAtIndexPath:indexPath];

    if (district.images.count == 0) {
        return;
    }
    
    dlog(@"setting dvc model");
    ImageVC *ivc = [[ImageVC alloc] init];
    
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:district.images.count];
    for (Image *img in district.images) {
        [paths addObject:[NSURL URLWithString:[[BASE_IMAGE_URL stringByAppendingString:@"/"] stringByAppendingString:img.path]]];
    }
    ivc.paths = paths;
    
    [self.navigationController pushViewController:ivc animated:YES];
}

@end








