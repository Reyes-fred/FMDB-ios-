//
//  ViewController.h
//  RegistroBD
//
//  Created by Alfredo Reyes on 11/3/16.
//  Copyright © 2016 Alfredo Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextField *apellido;
@property (weak, nonatomic) IBOutlet UITextField *direccion;
@property (weak, nonatomic) IBOutlet UITextField *edad;
@property (weak, nonatomic) IBOutlet UITextField *peso;
@property (weak, nonatomic) IBOutlet UITextField *estatura;
@property (weak, nonatomic) IBOutlet UITextField *padecimiento;
@property (weak, nonatomic) IBOutlet UITextField *medicamento;
@property (weak, nonatomic) IBOutlet UITextField *usuario;
@property (weak, nonatomic) IBOutlet UITextField *contrasena;



- (IBAction)mostrar:(id)sender;
- (IBAction)cancelar:(id)sender;
- (IBAction)guardar:(id)sender;


@end

