//
//  ZHMterialViewController.m
//  YCSideslip
//
//  Created by 崔敬轩 on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZHMterialViewController.h"
#import "Masonry.h"
#import "NetWorkingManager.h"
#import "UConfig.h"
#import "Btn_TableView.h"
// 角度转弧度
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f) // PI / 180
// 弧度转角度
#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f)

@interface ZHMterialViewController ()<Btn_TableViewDelegate>
{
    int sexCode;
    int professionCode;
    NSArray *professionArray;
}
@property(nonatomic,strong)UIScrollView*mterScroView;

@property(nonatomic,strong)UILabel*nameLbl;
@property(nonatomic,strong)UITextField*nameText;

@property(nonatomic,strong)UILabel*ageLbl;
@property(nonatomic,strong)UITextField*ageText;
//性别
@property(nonatomic,strong)UILabel*sexLbl;
@property(nonatomic,strong)UISegmentedControl*sexSeg;

@property(nonatomic,strong)UILabel*birLbl;
@property(nonatomic,strong)UITextField*birText;

@property(nonatomic,strong)UILabel*phoneLbl;
@property(nonatomic,strong)UILabel*phoneText;

@property(nonatomic,strong)UILabel*emailLbl;
@property(nonatomic,strong)UITextField*emailText;

@property(nonatomic,strong)UILabel*hospitalLbl;
@property(nonatomic,strong)UITextField*hospitalText;

@property(nonatomic,strong)UILabel*addLbl;
@property(nonatomic,strong)UITextField*addText;

@property(nonatomic,strong)UILabel*codeLbl;
@property(nonatomic,strong)UITextField*codeText;


@property(nonatomic,strong)UILabel*departmentLbl;
@property(nonatomic,strong)UITextField*departmentText;

@property(nonatomic,strong)UILabel*goodAtLbl;
@property(nonatomic,strong)UITextField*goodAtText;

@property(nonatomic,strong)UILabel*professionLbl;
//@property(nonatomic,strong)UITextField*professionText;


@property(nonatomic,strong)NSDictionary*merdict;

@property (strong , nonatomic) Btn_TableView* m_btn_tableView;


@end

@implementation ZHMterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _merdict = [UConfig getPersonInfo];
   self.view.backgroundColor=DWColor(245, 245, 245);
    sexCode = 1;
//   _merdict=[UConfig getPersonInfo];
//    NSLog(@"%111111111111@",_merdict);
//
//    if (_merdict!=nil) {
//        
//        _nameText.text=self.merdict[@"name"];
//        NSLog(@"%@",self.nameText.text);
//        self.phoneText.text=_merdict[@"mobile"];
//        self.emailText.text=_merdict[@"email"];
//        self.jobText.text=_merdict[@"job"];
//        self.addText.text=_merdict[@"code"];
//        
//    }
//    NSLog(@"%@",_merdict);
        self.title = @"基本资料";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:19],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        UIImage* image1 = [UIImage imageNamed:@"navigationbar_back_withtext"];
        // 告诉系统以后这张图片不进行默认的渲染
        image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage* image2 = [UIImage imageNamed:@"save"];
        // 告诉系统以后这张图片不进行默认的渲染
        image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // 创建活动的按钮
        UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(mterialClickleft)];
        
        UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:self action:@selector(mterialClickright)];
        self.navigationItem.leftBarButtonItem = item1;
        self.navigationItem.rightBarButtonItem = item2;
        [self setupUI];
        [self setupFrame];
    
    
    

}
-(void)setBtnMenuList
{
    
  
    
    
}
-(void)mterialClickleft{

    [self.nameText resignFirstResponder];
    [self.emailText resignFirstResponder];
    [self.hospitalText resignFirstResponder];
    [self.addText resignFirstResponder];
    [self.codeText resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupUI{
    
    _mterScroView=[[UIScrollView alloc]init];
    _mterScroView.showsVerticalScrollIndicator=NO;
    _mterScroView.showsHorizontalScrollIndicator=NO;
    _mterScroView.bounces=NO;
       //姓名
    _nameLbl=[[UILabel alloc]init];
    [_nameLbl setFont:[UIFont systemFontOfSize:15]];
    _nameLbl.text =@"真实姓名:";
    _nameLbl.textColor = DWColor(85,85,85);
    [_nameLbl setTextAlignment:NSTextAlignmentRight];

    _nameText=[[UITextField alloc]init];
    _nameText.text = _merdict[@"name"];
    _nameText.placeholder =@"请输入您的真实姓名（五个汉字之内）";
    _nameText.textColor = DWColor(166,171,185);

    [_nameText setFont:[UIFont systemFontOfSize:15]];
    [self.mterScroView addSubview:_nameLbl];
    [self.mterScroView addSubview:_nameText];
    
    
    
    
    //昵称
    _ageLbl=[[UILabel alloc]init];
    [_ageLbl setFont:[UIFont systemFontOfSize:15]];
    _ageLbl.text =@"年龄:";
    _ageLbl.textColor = DWColor(85,85,85);
    [_ageLbl setTextAlignment:NSTextAlignmentLeft];
    _ageText=[[UITextField alloc]init];
    _ageText.text = _merdict[@"age"];
    [_ageText setFont:[UIFont systemFontOfSize:15]];
    _ageText.placeholder = @"请输入年龄";
    _ageText.textColor = DWColor(166,171,185);
    _ageText.backgroundColor=DWColor(243, 243, 243);
    [self.mterScroView addSubview:_ageLbl];
    [self.mterScroView addSubview:_ageText];
    
    //性别
    _sexLbl=[[UILabel alloc]init];
    _sexLbl.text =@"性别:";
    _sexLbl.textColor = DWColor(85,85,85);

    [_sexLbl setTextAlignment:NSTextAlignmentLeft];
    [_sexLbl setFont:[UIFont systemFontOfSize:15]];
    _sexSeg=[[UISegmentedControl alloc]initWithItems:@[@"男",@"女"]];
    NSString *sexStr = _merdict[@"age"];
    if (![sexStr isEqualToString:@"1"]) {
        _sexSeg.selectedSegmentIndex = 1;

    }else{
        _sexSeg.selectedSegmentIndex = 0;

    }
    
    _sexSeg.tintColor = DWColor(70, 70, 70);
    [_sexSeg addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged]; //添加事件
    [self.mterScroView addSubview:_sexSeg];
    [self.mterScroView addSubview:_sexLbl];
    
    
    
    //出生日期
    _birLbl=[[UILabel alloc]init];
    _birLbl.text =@"出生日期:";
    _birLbl.textColor = DWColor(85,85,85);

    [_birLbl setTextAlignment:NSTextAlignmentLeft];
    [_birLbl setFont:[UIFont systemFontOfSize:15]];
    
    _birText=[[UITextField alloc]init];
    _birText.placeholder = @"请输入生日";
    _birText.backgroundColor=DWColor(243, 243, 243);
    _birText.textColor = DWColor(166,171,185);
    _birText.text = _merdict[@"birthday"];
    [_birText setFont:[UIFont systemFontOfSize:15]];
    [self.mterScroView addSubview:_birLbl];
    [self.mterScroView addSubview:_birText];
    
    //手机号
    _phoneLbl=[[UILabel alloc]init];
    _phoneLbl.text =@"手机号:";
    _phoneLbl.textColor = DWColor(85,85,85);

    [_phoneLbl setTextAlignment:NSTextAlignmentLeft];
    [_phoneLbl setFont:[UIFont systemFontOfSize:15]];
    _phoneText=[[UILabel alloc]init];
    _phoneText.text=[NSString stringWithFormat:@"%@",[UConfig getLoginNumber]];
    _phoneText.textColor = DWColor(166,171,185);

    [_phoneText setFont:[UIFont systemFontOfSize:15]];
    
    [self.mterScroView addSubview:_phoneLbl];
    [self.mterScroView addSubview:_phoneText];
    
    
    
      //科室
    _departmentLbl=[[UILabel alloc]init];
    _departmentLbl.text =@"科室:";
    _departmentLbl.textColor = DWColor(85,85,85);
    
    [_departmentLbl setTextAlignment:NSTextAlignmentLeft];
    [_departmentLbl setFont:[UIFont systemFontOfSize:15]];
    
    _departmentText=[[UITextField alloc]init];
    _departmentText.placeholder =@"请输入您所在科室";
    _departmentText.text = _merdict[@"department"];
    [_departmentText setFont:[UIFont systemFontOfSize:15]];
    _departmentText.textColor = DWColor(166,171,185);

    [self.mterScroView addSubview:_departmentLbl];
    [self.mterScroView addSubview:_departmentText];
    
    
    

    //擅长
    _goodAtLbl=[[UILabel alloc]init];
    _goodAtLbl.text =@"擅长:";
    _goodAtLbl.textColor = DWColor(85,85,85);
    
    [_goodAtLbl setTextAlignment:NSTextAlignmentLeft];
    [_goodAtLbl setFont:[UIFont systemFontOfSize:15]];
    
    _goodAtText=[[UITextField alloc]init];
    _goodAtText.placeholder =@"请输入擅长主治";
    _goodAtText.text = _merdict[@"goodAt"];

    [_goodAtText setFont:[UIFont systemFontOfSize:15]];
    _goodAtText.textColor = DWColor(166,171,185);

    [self.mterScroView addSubview:_goodAtLbl];
    [self.mterScroView addSubview:_goodAtText];

    
   
    
    

    //医师职称
    _professionLbl=[[UILabel alloc]init];
    _professionLbl.text =@"医师职称:";
    _professionLbl.textColor = DWColor(85,85,85);
    
    [_professionLbl setTextAlignment:NSTextAlignmentLeft];
    [_professionLbl setFont:[UIFont systemFontOfSize:15]];
    
//    _professionText=[[UITextField alloc]init];
//    _professionText.placeholder =@"请输入医师职称";
//     _professionText.text = _merdict[@"profession"];
//    [_professionText setFont:[UIFont systemFontOfSize:15]];
//    _professionText.textColor = DWColor(166,171,185);

    [self.mterScroView addSubview:_professionLbl];
//    [self.mterScroView addSubview:_professionText];
    
  
    //电子邮箱
    _emailLbl=[[UILabel alloc]init];
    _emailLbl.text =@"电子邮箱:";
    _emailLbl.textColor = DWColor(85,85,85);

    [_emailLbl setTextAlignment:NSTextAlignmentLeft];
    [_emailLbl setFont:[UIFont systemFontOfSize:15]];

    _emailText=[[UITextField alloc]init];
    _emailText.placeholder =@"请输入您的电子邮箱";
     _emailText.text = _merdict[@"email"];
    [_emailText setFont:[UIFont systemFontOfSize:15]];
    _emailText.textColor = DWColor(166,171,185);

    
    [self.mterScroView addSubview:_emailLbl];
    [self.mterScroView addSubview:_emailText];
    

    //工作单位
    _hospitalLbl=[[UILabel alloc]init];
    _hospitalLbl.text =@"所在医院:";
    _hospitalLbl.textColor = DWColor(85,85,85);

    [_hospitalLbl setTextAlignment:NSTextAlignmentLeft];
    [_hospitalLbl setFont:[UIFont systemFontOfSize:15]];

    _hospitalText=[[UITextField alloc]init];
    [_hospitalText setFont:[UIFont systemFontOfSize:15]];
     _hospitalText.text = _merdict[@"hospital"];
    _hospitalText.placeholder =@"请输入您所在医院";
    _hospitalText.textColor = DWColor(166,171,185);

    [self.mterScroView addSubview:_hospitalLbl];
    [self.mterScroView addSubview:_hospitalText];
    
    //通信地址
    _addLbl=[[UILabel alloc]init];
    _addLbl.text =@"通信地址:";
    _addLbl.textColor = DWColor(85,85,85);

    [_addLbl setTextAlignment:NSTextAlignmentLeft];
    [_addLbl setFont:[UIFont systemFontOfSize:15]];
    
    _addText=[[UITextField alloc]init];
    [_addText setFont:[UIFont systemFontOfSize:15]];
    _addText.textColor = DWColor(166,171,185);
     _addText.text = _merdict[@"address"];
    _addText.placeholder =@"请输入您的通信地址";
    [self.mterScroView addSubview:_addLbl];
    [self.mterScroView addSubview:_addText];
    
    //邮编
    _codeLbl=[[UILabel alloc]init];
    _codeLbl.text =@"邮编:";
    _codeLbl.textColor = DWColor(85,85,85);

    [_codeLbl setTextAlignment:NSTextAlignmentLeft];
    [_codeLbl setFont:[UIFont systemFontOfSize:15]];
    _codeText=[[UITextField alloc]init];
    [_codeText setFont:[UIFont systemFontOfSize:15]];
    _codeText.placeholder =@"请输入您的邮编";
    _codeText.textColor = DWColor(166,171,185);
     _codeText.text = _merdict[@"code"];
    [self.mterScroView addSubview:_codeLbl];
    [self.mterScroView addSubview:_codeText];
    
    [self.view addSubview:self.mterScroView];

}

-(void)setupFrame{
    
    [self.mterScroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
    }];
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mterScroView.mas_top).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mterScroView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.nameLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.ageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nameLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.ageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nameText.mas_left);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.sexLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ageLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.ageLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.sexSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ageText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.ageLbl.mas_right);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [self.birLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.sexLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.birText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexSeg.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.sexLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.phoneLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    
    [self.departmentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.departmentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.departmentLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    
    [self.goodAtLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.departmentText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.goodAtText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.departmentText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.goodAtLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];


    
    [self.professionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodAtText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    self.m_btn_tableView = [[Btn_TableView alloc] initWithFrame:CGRectMake(75, 290, 120, 30)];
    self.m_btn_tableView.delegate_Btn_TableView = self;
    [self.m_btn_tableView.m_btn setTitleColor:DWColor(166,171,185) forState:UIControlStateNormal];
    //按钮名字
    NSString *profession = _merdict[@"profession"];
    professionCode = profession.intValue;
    professionArray = @[@"住院医师",@"主治医师",@"副主任医师",@"主任医师"];
    
    if (profession.length<1) {
        self.m_btn_tableView.m_Btn_Name = @"选择医师职称";
    }else if(profession.intValue-1<=professionArray.count){
        self.m_btn_tableView.m_Btn_Name = professionArray[profession.intValue-1];
    }else{
        self.m_btn_tableView.m_Btn_Name = @"选择医师职称";
    }
    //数据内容
    self.m_btn_tableView.m_TableViewData = professionArray;
    [self.m_btn_tableView addViewData];
    [self.mterScroView addSubview:self.m_btn_tableView];

    
    
    [self.emailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.professionLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nameLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.professionLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.nameText.mas_left);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.hospitalLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.emailLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.hospitalText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.emailLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.addLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hospitalLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.hospitalLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.addText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hospitalText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.hospitalLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.codeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addLbl.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.addLbl.mas_left);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addText.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.addLbl.mas_right);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    [self.mterScroView.superview layoutIfNeeded];

    CGFloat scroH=CGRectGetMaxY(self.codeText.frame);
       NSLog(@"%f",scroH);
    
    _mterScroView.contentSize=CGSizeMake(kWidth, scroH*1.3);

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.nameText resignFirstResponder];
    [self.emailText resignFirstResponder];
    [self.hospitalText resignFirstResponder];
    [self.addText resignFirstResponder];
    [self.codeText resignFirstResponder];

}

- (void) segmentedAction:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl * segment = sender;
        if (segment.selectedSegmentIndex == 0) {
            sexCode =1;
        }else if (segment.selectedSegmentIndex == 1) {
            sexCode =1;
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    professionCode = indexPath.row+1;
    [self.m_btn_tableView changeName:professionArray[indexPath.row]];
    
}

-(void)changeOrientationNinty:(UIView *)view
{
    view.transform  = CGAffineTransformMakeRotation(CC_DEGREES_TO_RADIANS(90));
}



-(void)mterialClickright{
    
    [self.view endEditing:NO];
    //点击保存 储存
    NSDictionary*meteDict= @{@"id":[UConfig getDoctorId],@"name":_nameText.text,@"sex":[NSString stringWithFormat:@"%d",sexCode],@"age":self.ageText.text,@"mobile":_phoneText.text,@"department":_departmentText.text,@"goodAt":_goodAtText.text,@"birthday":_birText.text,@"profession":[NSString stringWithFormat:@"%d",professionCode],@"email":_emailText.text,@"hospital":_hospitalText.text,@"address":_addText.text};
    
    [YJProgressHUD showProgress:@"正在保存..." inView:self.view];

//    [NetWorkingManager sendPOSTDataWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/doct/edit"] withParamters:meteDict withProgress:^(float progress) {
//        
//    } success:^(BOOL isSuccess, id responseObject) {
//        NSLog(@"%@",responseObject);
//        [MBManager hideAlert];
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [MBManager hideAlert];
//
//    }];
    
    [NetWorkingManager sendPOSTImageWithPath:[NSString stringWithFormat:@"%@%@",BaseUrl,@"app/doct/upload"] withParamters:meteDict withImageArray:nil withtargetWidth:300 withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [YJProgressHUD hide];
            [YJProgressHUD showSuccess:@"保存成功" inview:self.view];
            
            NSDictionary *diction = responseObject[@"data"];
            if ([diction isKindOfClass:[NSDictionary class]]) {
                NSString *idStr = diction[@"id"];
                if (idStr.intValue>0) {
                    [UConfig setDoctorId:idStr];
                }
            }
        }else{
            [YJProgressHUD showSuccess:@"保存失败" inview:self.view];
            
        }
        
        [UConfig setPersonInfo:meteDict];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [YJProgressHUD hide];

        [YJProgressHUD showSuccess:@"保存失败，请检查网络" inview:self.view];
        
    }];

    
   
}

-(void)viewDidDisappear:(BOOL)animated
{
    [NetWorkingManager cancelAllNetworkRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
