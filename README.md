# TableViewBottomRefreshControl
Easy way to table view reload top and bottom refresh controller.

# UIRefreshControl
```
    refreshControl = [[UIRefreshControl alloc]init];
    [tbl addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    refreshControlBottom = [UIRefreshControl new];
    //refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@“Pull up to reload!“];
    refreshControlBottom.triggerVerticalOffset = 100.0f;
    [refreshControlBottom addTarget:self action:@selector(refreshBottom) forControlEvents:UIControlEventValueChanged];
    tbl.bottomRefreshControl = refreshControlBottom;

```
# Bottom TableViewRefreshControl Methods
```
- (void)refreshBottom {
    double delayInSeconds = 1.20f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tbl.bottomRefreshControl endRefreshing];
        [refreshControlBottom endRefreshing];
        [tbl reloadData];
    });
}
```
# Top TableViewRefreshControl Methods
```
- (void)refreshTable {
    double delayInSeconds = 1.20f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tbl.bottomRefreshControl endRefreshing];
        [refreshControl endRefreshing];
        [tbl reloadData];
    });
}
```
