//
//  DistrictCVC.m
//  WTS
//
//  Created by foo on 9/30/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DistrictCVC.h"
#import "District.h"
#import "Image+CD.h"
#import "DistrictCollectionCell.h"
#import "ImageVC.h"

static NSString *CellIdentifier = @"DistrictCollectionCell";

@interface DistrictCVC ()
@property (nonatomic, strong) UINib *nibForCell;
@end

@implementation DistrictCVC

- (IBAction)back:(id)sender {
    dlog();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UINib *) nibForCell {
    if (!_nibForCell) {
        _nibForCell = [UINib nibWithNibName:CellIdentifier bundle:[NSBundle mainBundle]];
        dlog(@"uinib: %@", [_nibForCell instantiateWithOwner:self options:nil]);
    }
    return _nibForCell;
}

- (void) viewDidLoad {
    [super viewDidLoad];

    // background of table view
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"45degreee_fabric.gif"]];
    self.collectionView.backgroundView = tempImageView;
    
    // register cell
    [self.collectionView registerNib:self.nibForCell forCellWithReuseIdentifier:CellIdentifier];
}

#pragma mark - Collection view data source

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView
                   cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DistrictCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    District *district = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // use any old image for now
    if (district.images.count > 0) {
        Image *selectedImage = [district.images anyObject];
        NSURL *imgUrl = [Image getLocalUrlFromPathThumb:selectedImage.path];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        cell.thumb.image = img;
    }
    
    cell.title.text = district.name;
    
    UIView *v = cell.contentView;
    
    v.backgroundColor = [UIColor darkGrayColor];
    
    [v.layer setCornerRadius:15.0f];
    
    return cell;
}

#pragma mark - Collection view delegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
