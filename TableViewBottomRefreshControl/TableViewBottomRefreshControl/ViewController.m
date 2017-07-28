//
//  ViewController.m
//  TableViewBottomRefreshControl
//
//  Created by wos on 28/07/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+BottomRefreshControl.h"
#import "TempTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrTemp;
    __weak IBOutlet UITableView *tbl;
    UIRefreshControl *refreshControl;
    UIRefreshControl *refreshControlBottom;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrTemp = [[NSMutableArray alloc] init];
    NSInteger intVal = 0;
    for (NSInteger i = 0; i < 25; i++)
    {
        intVal = intVal + 1;
        [arrTemp addObject:[NSString stringWithFormat:@"%ld",(long)intVal]];
    }
    [tbl reloadData];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [tbl addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    refreshControlBottom = [UIRefreshControl new];
    //refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@“Pull up to reload!“];
    refreshControlBottom.triggerVerticalOffset = 100.0f;
    [refreshControlBottom addTarget:self action:@selector(refreshBottom) forControlEvents:UIControlEventValueChanged];
    tbl.bottomRefreshControl = refreshControlBottom;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableRefresh
- (void)refreshBottom {
    double delayInSeconds = 1.20f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tbl.bottomRefreshControl endRefreshing];
        [refreshControlBottom endRefreshing];
        [tbl reloadData];
    });
}
- (void)refreshTable {
    double delayInSeconds = 1.20f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tbl.bottomRefreshControl endRefreshing];
        [refreshControl endRefreshing];
        [tbl reloadData];
    });
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrTemp count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TempTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.lblNumber.text = [arrTemp objectAtIndex:indexPath.row];
    return cell;
}


@end
