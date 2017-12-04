//
//  RecordViewController.m
//  ClockCard
//
//  Created by lv on 2017/11/24.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, strong) UITableView *recordTableView;
@property (nonatomic, strong) NSMutableArray *recordArrs;


@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _recordArrs = [[NSMutableArray alloc] init];
    
    [self.view addSubview: self.recordTableView];
    [self.recordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.f);
        make.left.mas_equalTo(0.f);
        make.right.mas_equalTo(0.f);
        make.bottom.mas_equalTo(0.f);
    }];
    
    //获取数据
    [self requestData];
}

#pragma mark - request Data
- (void) requestData
{
    [_recordArrs removeAllObjects];
    
    //所有字体
    NSArray *array = [UIFont familyNames];
    NSString *familyName ;
    for(familyName in array)
    {
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        [_recordArrs addObjectsFromArray:names];
    }
    NSLog(@"%@", _recordArrs);
    
    [self.recordTableView reloadData];
}

#pragma mark - UITableViewDelegate / UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_recordArrs count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierStr = @"recordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifierStr];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifierStr];
    }

    NSString *fontNameStr = _recordArrs[indexPath.row];
    [cell.textLabel setFont: [UIFont fontWithName: fontNameStr size: 15.f]];
    [cell.textLabel setText: [NSString stringWithFormat: @"11月 24  字体： %@", fontNameStr]];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fontNameStr = _recordArrs[indexPath.row];
    NSLog(@"fontNameStr = %@", fontNameStr);
}

#pragma mark - setter / getter
- (UITableView *) recordTableView
{
    if (_recordTableView == nil)
    {
        _recordTableView = [[UITableView alloc] init];
        _recordTableView.delegate = self;
        _recordTableView.dataSource = self;
    }
    
    return _recordTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
