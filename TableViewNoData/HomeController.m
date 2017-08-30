//
//  HomeController.m
//  TableViewNoData
//
//  Created by Z on 2017/8/29.
//  Copyright © 2017年 Z. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define WEAK_SELF(value) __weak typeof(self) value = self

#import "HomeController.h"
#import "UIBarButtonItem+Extension.h"
#import "UITableView+placeholder.h"
#import "GMTableViewNoDataView.h"


@interface HomeController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * infoTableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation HomeController
#pragma mark - Lazy loading           懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - LifeCyle               生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TableViewNoData";
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"添加数据" target:self action:@selector(leftNavBarItem:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"清空数据" target:self action:@selector(rightNavBarItem:)];
    
    [self loadData];
    
    [self initTableView];
    
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

- (void)dealloc {
    NSLog(@"%@--->释放了",self.class);
}



#pragma mark - Initial control        初始化控件
//初始化界面
- (void)createViews {
    
}

//初始化Tableview
- (void)initTableView {
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _infoTableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
    _infoTableView.backgroundColor = [UIColor whiteColor];
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    [self.view addSubview:_infoTableView];
    //去掉cell的分割线
    //self.infoTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //去掉没有数据的分割线
    self.infoTableView.tableFooterView = [UIView new];
}



//初始化数据
- (void)loadData {
    for (int i = 0; i < 10; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"测试数据测试数据"]];
    }
    [self.infoTableView reloadData];
}

//加载更多数据
- (void)loadMoreData {

}

#pragma mark - Action  Method         控件事件

- (void)leftNavBarItem:(UIButton *)sender {
    
    [self loadData];
    
}

- (void)rightNavBarItem:(UIButton *)sender {
  
    [self.dataArray removeAllObjects];
    
    WEAK_SELF(weakSelf);
    if (self.dataArray.count == 0) {

        if (!_infoTableView.placeHolderView) {
            _infoTableView.placeHolderView = [[GMTableViewNoDataView alloc] initWithFrame:self.view.bounds image:[UIImage imageNamed:@"no_data"] viewClick:^{
                
                [weakSelf loadData];
                
                [weakSelf.infoTableView reloadData];
            }];
        }
    }
    [self.infoTableView reloadData];
}


#pragma mark - Private Method         私有方法

#pragma mark - Set/Get Methods        重写设值/取值

#pragma mark - External Delegate      外部代理

#pragma mark - Notification           通知方法

#pragma mark - UITableView            代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString * cellID = @"cellID";
 
     UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
     if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
     }
     cell.textLabel.text = [NSString stringWithFormat:@"测试数据测试数据 第%ld行",(long)indexPath.row];

     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSLog(@"%ld",(long)indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - 系统自带左滑删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //删除的逻辑
}

#pragma mark - OtherMethods           其他方法


@end
