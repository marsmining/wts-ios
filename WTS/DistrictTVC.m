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
#import "DistrictCell.h"

static NSString *CellIdentifier = @"DistrictCell";

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

- (NSString *) trimLeadingBy:(NSUInteger) trimAmt fromString:(NSString *) name {
    if (name.length > trimAmt)
        return [name substringFromIndex:trimAmt];
    else return name;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self trimLeadingBy: 7 fromString:
            [[[self.fetchedResultsController sections] objectAtIndex:section] name]];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DistrictCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                         forIndexPath:indexPath];
    
    if (!cell) {
        dlog("error - dequeue should work");
        cell = [[DistrictCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellIdentifier];
    }
    
    District *district = [self.fetchedResultsController objectAtIndexPath:indexPath];

    // use any old image for now
    if (cell.thumb.image == nil && district.images.count > 0) {
        Image *selectedImage = [district.images anyObject];
        NSURL *imgUrl = [Image getLocalUrlFromPathThumb:selectedImage.path];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        cell.thumb.image = img;
    }

//    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//    cell.indentationLevel = 0;

    cell.title.text = district.name;
    cell.subtitle.text = [NSString stringWithFormat:@"image count: %d", district.images.count];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dlog();
    
    District *district = [self.fetchedResultsController objectAtIndexPath:indexPath];

    if (district.images.count == 0) {
        return;
    }
    
    dlog(@"setting dvc model");
    ImageVC *ivc = [[ImageVC alloc] init];
    ivc.path = [[district.images anyObject] path];
    
    [self.navigationController pushViewController:ivc animated:YES];
}

@end








