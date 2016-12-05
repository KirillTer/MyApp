#import "TableViewController.h"
#import "TableViewCell.h"
#import "Backendless.h"
#import "test.h"

@interface TableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *uploadButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic) NSNumber *page;
@property (nonatomic) NSArray *data;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class])
                                               bundle:nil] forCellReuseIdentifier:NSStringFromClass([TableViewCell class])];
    self.page = @0;
}
- (void) viewWillAppear:(BOOL)animated {
    [self uploadData:self.page];
}

- (IBAction)uploadAction:(id)sender {
    [self uploadData:self.page];
}

- (IBAction)backAction:(id)sender {
    int value = [self.page intValue];
    if ([self.page intValue] > 0) {
        self.page = [NSNumber numberWithInt:value - 1];
        [self uploadData:self.page];
    }
}

- (IBAction)forwardAction:(id)sender {
    int value = [self.page intValue];
    self.page = [NSNumber numberWithInt:value + 1];
    [self uploadData:self.page];
}

- (void)uploadData:(NSNumber*)page {
    QueryOptions *queryOptions = [QueryOptions query];
    queryOptions.relationsDepth = @1;
    BackendlessDataQuery *dataQuery = [BackendlessDataQuery query];
    dataQuery.queryOptions = queryOptions;
    dataQuery.whereClause = [NSString stringWithFormat:@"age > 2"];
    dataQuery.queryOptions = [[QueryOptions query] sortBy:@[@"age"]];
    dataQuery.queryOptions.pageSize = @10;
    dataQuery.queryOptions.offset = page;
    
   
    [[backendless.persistenceService of:[test class]] find:^(BackendlessCollection *collection) {
        self.data = collection.data;
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.tableView reloadData];
        });
    } error:^(Fault *fault) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class]) forIndexPath:indexPath];
    cell.nameLabel.text = [[self.data objectAtIndex:indexPath.row] valueForKeyPath:@"name"];
    cell.ageLabel.text = [NSString stringWithFormat:@"%@",[[self.data objectAtIndex:indexPath.row] valueForKeyPath:@"age"]];
    cell.birthDayLabel.text = [NSString stringWithFormat:@"%@",[[self.data objectAtIndex:indexPath.row] valueForKeyPath:@"birthday"]];
    return cell;
}

@end
