//
//  cmp_login_view.h
//  cmp_login
//
//  Created by Vincenzo on 17/10/13.
//  Copyright (c) 2013 Vincenzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFHTTPRequestOperation.h>
#import <AFNetworkReachabilityManager.h>
#import <UIImageView+AFNetworking.h>


@protocol cmp_login_protocol

-(void)loginSuccess:(id)response; //Method executed after a succeful login
-(void)loginError:(id)errorStatus; //Method executed after a failed login




@end



@interface cmp_login_view : UIViewController <UIScrollViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *urls; //Array degli indirizzi delle immagini ricevuti dal server
    NSMutableArray *images; //Array delle UIImageView
    int index; //Indice per scorrere le immagini
    int number_images;//Numero di immagini pubblicità
    BOOL login_show; //Flag che indica che la maschera di login è stata visualizzata
    UIView *mask; //Maschera per il modale
    
    IBOutlet UIScrollView *scroll;
    IBOutlet UIImageView *framePicture;
    IBOutlet UIView *loginView;
    IBOutlet UIPageControl *pageControll;
    IBOutlet UIView *notificationView;
    IBOutlet UILabel *notificationText;
    
    NSString *spotsUrl; //Url per il download delle immagini
    NSString *loginUrl; //Url per il corretto Logins
    
    
}
@property (nonatomic,retain) id <cmp_login_protocol> delegate; //delegate 


//Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andSpotsUrl:(NSString*)urlSpots andLoginUrl:(NSString*)urlLogin;

@end
