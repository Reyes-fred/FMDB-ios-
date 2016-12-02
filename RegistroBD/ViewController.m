//
//  ViewController.m
//  RegistroBD
//
//  Created by Alfredo Reyes on 11/3/16.
//  Copyright © 2016 Alfredo Reyes. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDB.h"

@interface ViewController ()

@end

@implementation ViewController

int x=0;
NSArray *datos;
FMResultSet *results;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //Get the default file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //get the path to the user's Document Directory(NSDocumentDirectory)
    NSURL *dbUrl = [fileManager URLForDirectory:NSDocumentDirectory
                                       inDomain:NSUserDomainMask appropriateForURL:nil
                                         create:nil error:nil];
    //append the db filename to URL path
    dbUrl = [dbUrl URLByAppendingPathComponent:@"usuario.db"];
    
    //need a string for FMDatabase object
    NSString *dbUrlStr = dbUrl.absoluteString;
    //create the database file if it doesn't exits
    FMDatabase * db = [FMDatabase databaseWithPath:dbUrl.absoluteString];
    // Do any additional setup after loading the view, typically from a nib.
    if([db open]){//open the db
        //string to create a table in the database
        NSString *dbCarTableCreate = @"CREATE TABLE IF NOT EXISTS user("
        "ID integer primary key autoincrement,"
        "nombre VARCHAR NOT NULL,"
        "apellido VARCHAR NOT NULL,"
        "direccion VARCHAR NOT NULL,edad VARCHAR NOT NULL,peso VARCHAR NOT NULL,estatura VARCHAR NOT NULL,padecimiento VARCHAR NOT NULL,medicamento VARCHAR NOT NULL,usuario VARCHAR NOT NULL,contrasena VARCHAR NOT NULL);";
        //execute the create table statement
        if([db executeUpdate:dbCarTableCreate]){
            NSLog(@"Table create success");
        }else{
            NSLog(@"%@",db.lastError);
            NSLog(@"%@",db.lastErrorMessage);
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)mostrar:(id)sender {
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"usuario.db"];
 
    if(x==0){
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    results = [database executeQuery:@"SELECT * FROM user"];
    
    }
    
  
    if(results.next){
        
        self.nombre.text =[results stringForColumn:@"nombre"];
        self.apellido.text =[results stringForColumn:@"apellido"];
        self.direccion.text =[results stringForColumn:@"direccion"];
        self.edad.text= [results stringForColumn:@"edad"];
        self.peso.text=[results stringForColumn:@"peso"];
        self.estatura.text=[results stringForColumn:@"estatura"];
        self.padecimiento.text=[results stringForColumn:@"padecimiento"];
        self.medicamento.text=[results stringForColumn:@"medicamento"];
        
        self.usuario.text=[results stringForColumn:@"usuario"];
        self.contrasena.text=[results stringForColumn:@"contrasena"];
        
        NSLog(@"%@", [results stringForColumn:@"nombre"]);
       }
    else{
        x=0;
    }
    
      x++;
    
}

- (IBAction)cancelar:(id)sender {
     self.nombre.text =@"";
    self.apellido.text =@"";
    self.direccion.text =@"";
    self.edad.text=@"";
    self.peso.text=@"";
    self.estatura.text=@"";
    self.padecimiento.text=@"";
    self.medicamento.text=@"";
    self.usuario.text=@"";
    self.contrasena.text=@"";
    
}



- (IBAction)guardar:(id)sender {
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"usuario.db"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    [database executeUpdate:@"INSERT INTO user (nombre, apellido, direccion, edad, peso,estatura,padecimiento,medicamento,usuario,contrasena) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",[NSString stringWithFormat:@"%@", self.nombre.text],[NSString stringWithFormat:@"%@", self.apellido.text],[NSString stringWithFormat:@"%@", self.direccion.text],[NSString stringWithFormat:@"%@", self.edad.text],[NSString stringWithFormat:@"%@", self.peso.text],[NSString stringWithFormat:@"%@", self.estatura.text],[NSString stringWithFormat:@"%@", self.padecimiento.text],[NSString stringWithFormat:@"%@", self.medicamento.text],[NSString stringWithFormat:@"%@", self.usuario.text],[NSString stringWithFormat:@"%@", self.contrasena.text]];
    [database close];
     [self alerta:@"Contacto Agregado" :@"" :0];
}



- (void) alerta:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

@end
