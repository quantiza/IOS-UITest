//
//  UTTextFieldController.m
//  ios-UITest
//
//  Created by yangl on 2016/11/2.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "UTTextFieldController.h"
#import "FitConsts.h"
#import "MultiLabelView.h"

@interface UTTextFieldController () <UITextFieldDelegate, MultilabelViewDelegate>

@end

@implementation UTTextFieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    
    // Do any additional setup after loading the view.
}

- (void)initLayout {
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"UITextField Test";
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, kScreenWidth-40, 40)];
    textField1.tag = 101;
    textField1.userInteractionEnabled = YES;             //可否交互,默认yes
    textField1.delegate = self;
    //1.占位文字设置,颜色，字号
    //或者通过attributedPlaceholder设置
    textField1.placeholder = @"placeholder -> userInteraction = NO";
    [textField1 setValue:RED_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [textField1 setValue:TEXT_FONT_LEVEL_3 forKeyPath:@"_placeholderLabel.font"];
    
    //2.设置边框
    //textField1.borderStyle = UITextBorderStyleLine;
    //textField1.borderStyle = UITextBorderStyleBezel;
    textField1.borderStyle = UITextBorderStyleRoundedRect;  //圆角
    textField1.layer.borderColor = PURPLE_COLOR.CGColor;    //边框色
    textField1.layer.borderWidth = 2.0f;                    //边框线宽
    
    //3.font属性，对齐
    textField1.font = TEXT_FONT_LEVEL_3;
    textField1.textColor = COLOR_RED_LIGHT;
    //textField1.adjustsFontSizeToFitWidth = YES;       //根据边框自动调整大小
    textField1.textAlignment = NSTextAlignmentCenter;
    
    //4.与键盘相关属性
    textField1.keyboardType = UIKeyboardTypeDefault;  //键盘样式
    textField1.autocapitalizationType = UITextAutocapitalizationTypeNone; //大写格式
    textField1.keyboardAppearance = UIKeyboardAppearanceDark; //键盘外观
    textField1.returnKeyType = UIReturnKeyDone; //return键
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:textField1];
	
    [self.view addSubview:textField1];
	
	MultiLabelView *view = [[MultiLabelView alloc] initWithFrame:CGRectMake(100, 10, kScreenWidth-20, 0) andArray:@[@"hello", @"aljfd",@"hello", @"aljfd",@"hello", @"aljfd",@"hello", @"aljfd",@"hello", @"aljfd"]];
	view.delegate = self;
	view.backgroundColor = BG_GRAY_COLOR;
	[self.view addSubview:view];
}

- (void)multilabelClickWithIndex:(NSInteger)index
{
	NSLog(@"index:%lu", index);
}


- (void)textFieldTextDidChange {
    UITextField *tf = (UITextField *)[self.view viewWithTag:101];
    NSLog(@"=================%lu",tf.text.length);
}

//5.委托方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //a. 是否允许文本开始编辑
    NSLog(@"====================Should Begin Editing...");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //b. 开始编辑时触发，文本字段将成为first responder
    NSLog(@"===================nDid Begin Editing...");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    //d. 允许结束编辑
    NSLog(@"===================Should Edn Editing...");
    return YES;
    ;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"==========================ShouldClear");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //c. return结束编辑
    NSLog(@"=====================Return");
    [textField resignFirstResponder];
    return YES;
}



@end
