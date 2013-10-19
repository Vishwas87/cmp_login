//
//  cmp_login_view.h
//  cmp_login
//
//  Created by Vincenzo on 17/10/13.
//  Copyright (c) 2013 Vincenzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFHTTPRequestOperation.h>
#import <UIImageView+AFNetworking.h>
@interface cmp_login_view : UIViewController <UIScrollViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *urls; //Array degli indirizzi delle immagini ricevuti dal server
    NSMutableArray *images; //Array delle UIImageView
    int index; //Indice per scorrere le immagini
    BOOL login_show; //Flag che indica che la maschera di login è stata visualizzata
    int number_images;//Numero di immagini pubblicità
    
    UIView *mask; //Maschera per il modale
    
}
@property (nonatomic,retain) IBOutlet UIScrollView *scroll;
@property (nonatomic,retain) IBOutlet UIImageView *framePicture;
@property (nonatomic,retain) IBOutlet UIView *loginView;
@property (nonatomic,retain) IBOutlet UIPageControl *pageControll;
@end
