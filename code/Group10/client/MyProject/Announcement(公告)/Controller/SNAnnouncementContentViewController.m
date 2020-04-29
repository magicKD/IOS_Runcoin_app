//
//  SNAnnouncementContentViewController.m
//  MyProject
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNAnnouncementContentViewController.h"

#import "HomeGoodsFrame.h"
#import "HomeGoodsModel.h"
#import "HomePriceView.h"

#define CellPadding 10
#define PicPadding 5
#define PicHeight (SCREEN_WIDTH - CellPadding*2-2*PicPadding)/3

@interface SNAnnouncementContentViewController ()


@property (nonatomic,weak) UIImageView *headIconView;
@property (nonatomic,weak) UILabel *nickNameLabel;
@property (nonatomic,weak) UILabel *addTimeLabel;
@property (nonatomic,weak) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView * contentImage;

@property (nonatomic,weak) UIButton *locateBtn;
@property (nonatomic,weak) UIButton *assessBtn;
@property (nonatomic,weak) UIView *photosView;

@end

@implementation SNAnnouncementContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.title = @"社区公告";
    self.title = @"社区公告";
    
    [self createContentView];
    
    HomeGoodsModel *goodModel = [[HomeGoodsModel alloc] init];
    goodModel.nickName = [NSString stringWithFormat:@"中本聪"];
    goodModel.addTime = @"1435912294000";
    goodModel.headIcon = @"";
    goodModel.realPrice = @"100";
    goodModel.orignPrice = @"150";
    goodModel.pics = @[@"",@"",@""];
    goodModel.content = @"获币方式：跑步运动\n交易方式：\n1.去中心化交易\n2.交易双方先压2倍的交易金额\n3.交易成功金额退还\n4.任何一方以任何形式毁约，交易失败，双方押金冻结";
    goodModel.location = @"社区";
    
    [self setGoodFrame:goodModel];
}


-(void)createContentView
{

    UIImageView *headIcon = [[UIImageView alloc] init];
    [self.view addSubview:headIcon];
    self.headIconView = headIcon;

    UILabel *nickName = [[UILabel alloc] init];
    nickName.textColor = [UIColor blackColor];
    nickName.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:nickName];
    self.nickNameLabel = nickName;

    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:timeLabel];
    self.addTimeLabel = timeLabel;



    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor blackColor];
    self.contentLabel = contentLabel;
    
    [self.view addSubview:contentLabel];
    

    UIView *photosView = [[UIView alloc] init];
    [self.view addSubview:photosView];
    self.photosView = photosView;
    
    self.contentImage = [[UIImageView alloc] init];
    self.contentImage.image = [UIImage imageNamed:@"blockchainImage"];
    [self.view addSubview:self.contentImage];


    UIButton *locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [locateBtn setImage:[UIImage imageNamed:@"my_city_position_green"] forState:UIControlStateNormal];
    [locateBtn setTitleColor:LocateColor forState:UIControlStateNormal];
    locateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [locateBtn addTarget:self action:@selector(locateDidClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locateBtn];
    self.locateBtn = locateBtn;


    UIButton *assessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [assessBtn setBackgroundImage:[UIImage imageNamed: @"meta_action"] forState:UIControlStateNormal];
    [assessBtn addTarget:self action:@selector(assessBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    assessBtn.size = assessBtn.currentBackgroundImage.size;
    [self.view addSubview:assessBtn];
    self.assessBtn = assessBtn;
}

-(void)setGoodFrame:(HomeGoodsModel *)goodModel
{

    CGFloat headIconX = CellPadding;
    CGFloat headIconY = CellPadding;
    CGFloat headIconWH = 40;
    self.headIconView.frame = CGRectMake(headIconX, headIconY, headIconWH, headIconWH);
    [self.headIconView sd_setImageWithURL:[NSURL URLWithString:goodModel.headIcon] placeholderImage:[UIImage imageNamed:@"avatar_placehold"]];

    
    CGFloat nickNameX = CGRectGetMaxX(self.headIconView.frame)+CellPadding;
    CGFloat nickNameY = headIconY;
    CGSize  nickeNameSize = [goodModel.nickName sizeWithTextfont:[UIFont systemFontOfSize:14] maxW:100];
    self.nickNameLabel.frame = (CGRect){{nickNameX,nickNameY},nickeNameSize};
    self.nickNameLabel.text = goodModel.nickName;


    CGFloat timeX = nickNameX;
    CGFloat timeY = CGRectGetMaxY(self.nickNameLabel.frame)+CellPadding;
    CGSize  timeSize = [[NSString addtime:goodModel.addTime] sizeWithTextfont:[UIFont systemFontOfSize:12] maxW:200];
    self.addTimeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.addTimeLabel.text = [NSString addtime:goodModel.addTime];

    self.contentImage.frame = CGRectMake(CellPadding, CGRectGetMaxY(self.addTimeLabel.frame) + 10, self.view.frame.size.width - 2 * CellPadding, 150);


    
    CGFloat contentX = CellPadding;
    CGFloat contentY = CGRectGetMaxY(self.contentImage.frame) + 10;
    CGSize  contentSize = [goodModel.content sizeWithTextfont:[UIFont systemFontOfSize:14] maxW:self.view.frame.size.width - 2*CellPadding];
    self.contentLabel.frame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height * 2);//contentSize.height
    self.contentLabel.text = goodModel.content;
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 20;
    style.lineSpacing = 10;
    style.alignment = NSTextAlignmentLeft;
    NSRange range = NSMakeRange(0, self.contentLabel.text.length);
    [text addAttribute:NSParagraphStyleAttributeName value:style range:range];
    self.contentLabel.attributedText = text;

    CGFloat locateX = CellPadding;
    CGFloat locateY = CGRectGetMaxY(self.contentLabel.frame)+CellPadding;
    CGFloat locateW = 200;
    CGFloat locateH = 20;
    self.locateBtn.frame = CGRectMake(locateX, locateY, locateW, locateH);

    [self.locateBtn setTitle:[NSString stringWithFormat:@"来自%@",goodModel.location] forState:UIControlStateNormal];


    CGFloat assessW = 19;
    CGFloat assessH = 14;
    CGFloat assessX = self.view.frame.size.width - CellPadding- assessW;
    CGFloat assessY = locateY;
    self.assessBtn.frame = CGRectMake(assessX, assessY, assessW, assessH);
}

-(void)locateDidClickEvent:(UIButton *)btn
{
    
}
-(void)assessBtnDidClick:(UIButton *)btn
{
    
}
@end
