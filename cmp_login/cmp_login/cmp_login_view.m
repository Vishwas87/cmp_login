//
//  cmp_login_view.m
//  cmp_login
//
//  Created by Vincenzo on 17/10/13.
//  Copyright (c) 2013 Vincenzo. All rights reserved.
//

#import "cmp_login_view.h"

@interface cmp_login_view ()

@end

@implementation cmp_login_view

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
        images = [[NSMutableArray alloc] init];
        urls = [[NSMutableArray alloc]init];
        index = 0;
        mask = NULL;
        
    }
    return self;
}

- (IBAction)showingLogin
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if([mask superview] == NULL){
            [self.view addSubview:mask];
            [self.view addSubview:self.loginView];
        }
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 animations:^{
            [mask setAlpha:1.0];
            [self.loginView setAlpha:1.0];

        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Inizializzazione
    mask = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    [mask setBackgroundColor:[UIColor grayColor]];
    
    self.loginView.frame = CGRectMake((self.view.frame.size.width/2) - (self.loginView.frame.size.width/2), (self.view.frame.size.height/2) - (self.loginView.frame.size.height/2) - 50, self.loginView.frame.size.width, self.loginView.frame.size.height);
    
    CALayer * loginBorder = [self.loginView layer];
    [loginBorder setMasksToBounds:YES];
    [loginBorder setCornerRadius:10];
    [mask setAlpha:0.0];
    [self.loginView setAlpha:0.0];
    
   

    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        number_images = [responseObject count];
        if([responseObject count]>0){
     
            //Creazione della maschera del modale
            

            
            
            
            [self.scroll setContentSize:CGSizeMake((self.scroll.frame.size.width) * [responseObject count], self.scroll.frame.size.height)];
            
            [responseObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [urls insertObject:obj atIndex:idx];

                NSURL *ul = [[NSURL alloc] initWithString:[urls objectAtIndex:idx]];
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((self.scroll.frame.size.width ) * idx, 0, self.scroll.frame.size.width  , self.scroll.frame.size.height )];
                
                [images insertObject:img atIndex:idx];
                [img setImageWithURL:ul placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
               
                //Bordi arrotondati
                CALayer * l = [img layer];
                [l setMasksToBounds:YES];
                [l setCornerRadius:10];
                
                
                
                self.scroll.center = self.framePicture.center;
                
                [self.scroll addSubview:img];
                
                
                

                
            }];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error	);
    }];
    [operation start];
    
    
    
}


-(void)scrollViewDidScroll:(UIScrollView*)scrollView
{
	const CGFloat currPos = scrollView.contentOffset.x;
	const NSInteger selectedPage = lroundf(currPos / self.scroll.frame.size.width);
	const NSInteger zone = 1 + (selectedPage % 3);
	const NSInteger nextPage = selectedPage + 1;
	const NSInteger prevPage = selectedPage - 1;
	/// Next page
    
	if (nextPage < number_images)
	{
		NSInteger nextViewTag = zone + 1;
		if (nextViewTag == 4)
			nextViewTag = 1;
		UIImageView* nextView = (UIImageView*)[scrollView viewWithTag:nextViewTag];
		nextView.frame = CGRectMake(nextPage * 300, 0, 300, 400);
		NSString *str = [NSString stringWithFormat:@"tiger%d.jpg", nextPage];
		UIImage* img = [UIImage imageNamed:str];
		nextView.image = img;
	}
	/// Prev page
	if (prevPage >= 0)
	{
		NSInteger prevViewTag = zone - 1;
		if (!prevViewTag)
			prevViewTag = 3;
		UIImageView* prevView = (UIImageView*)[scrollView viewWithTag:prevViewTag];
		prevView.frame = (CGRect){.origin.x = prevPage * 300, .origin.y = 0.0f, .size = prevView.frame.size};
		NSString *str = [NSString stringWithFormat:@"tiger%d.jpg", prevPage];
		UIImage* img = [UIImage imageNamed:str];
		prevView.image = img;
	}
}


#pragma -- Keyboard Hidding

//Metodi per scorrere la view quando appare la tastiera


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(IBAction) slideFrameUp
{
    [self slideFrame:YES];
}

-(IBAction) slideFrameDown
{
    [self slideFrame:NO];
}

-(void) slideFrame:(BOOL) up
{
    const int movementDistance = 70; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma closing loginview

-(IBAction)dismissingLoginView
{
    
    
    [UIView animateWithDuration:1.0 animations:^{
        
            [mask setAlpha:0];
            [self.loginView setAlpha:0];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
