#import "StylePickerTableViewCell.h"
#include <notify.h>

static CGFloat kCellSize = 210.f;

@implementation StylePickerTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self) {
        [self setClipsToBounds:YES];
        [self.contentView.widthAnchor constraintEqualToConstant:kCellSize].active = YES;
        [self.contentView.heightAnchor constraintEqualToConstant:kCellSize].active = YES;

        if (!_leftOptionView) {
            _leftOptionView = [[StylePickerOptionView alloc] initWithFrame:CGRectZero appearanceOption:0 properties:specifier.properties];
            NSLog(@"StylePicker: Specifier: %@, Properties: %@", specifier, specifier.properties);
            _leftOptionView.delegate = (id<StylePickerOptionViewDelegate>)self;
            _leftOptionView.translatesAutoresizingMaskIntoConstraints = false;
            [self.contentView addSubview:_leftOptionView];
        }

        if (!_rightOptionView) {
            _rightOptionView = [[StylePickerOptionView alloc] initWithFrame:CGRectZero appearanceOption:1 properties:specifier.properties];
            _rightOptionView.delegate = (id<StylePickerOptionViewDelegate>)self;
            _rightOptionView.translatesAutoresizingMaskIntoConstraints = false;
            [self.contentView addSubview:_rightOptionView];
        }

        [_leftOptionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15].active = YES;
        [_leftOptionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-15].active = YES;
        [_leftOptionView.widthAnchor constraintEqualToConstant:60].active = YES;
        [_leftOptionView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:75].active = YES;

        [_rightOptionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15].active = YES;
        [_rightOptionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-15].active = YES;
        [_rightOptionView.widthAnchor constraintEqualToConstant:60].active = YES;
        [_rightOptionView.leadingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:25].active = YES;    
    }
    return self;
}
-(void)userDidTapOnAppearanceOptionView:(StylePickerOptionView *)sender {
    NSNumber *someNumber = [NSNumber numberWithUnsignedLongLong:sender.appearanceOption];

   	NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", self.specifier.properties[@"defaults"]]];

	[settings setObject:someNumber forKey:self.specifier.properties[@"key"]];
	[settings writeToURL:[NSURL URLWithString:[NSString stringWithFormat:@"file:///var/mobile/Library/Preferences/%@.plist", self.specifier.properties[@"defaults"]]] error:nil];
	CFPreferencesSetAppValue((CFStringRef)self.specifier.properties[@"key"], (CFNumberRef)someNumber, (CFStringRef)self.specifier.properties[@"defaults"]);

    [_leftOptionView _updateViewForCurrentStyle:sender.appearanceOption];
    [_rightOptionView _updateViewForCurrentStyle:sender.appearanceOption];

}
- (CGFloat)preferredHeightForWidth:(CGFloat)width {
    return 210.0f;
}
- (CGFloat)preferredHeightForWidth:(CGFloat)width inTableView:(id)tableView {
    return [self preferredHeightForWidth:width];
}
- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", self.specifier.properties[@"defaults"]]];
	NSNumber *num = [settings objectForKey:self.specifier.properties[@"key"]] ?: self.specifier.properties[@"default"];
    unsigned long long apOption = [num longLongValue];

    switch (apOption) {
        case 0:
            _leftOptionView.enabled = YES;
            _rightOptionView.enabled = NO;
            break;
        case 1:
            _leftOptionView.enabled = NO;
            _rightOptionView.enabled = YES;
            break;
    }
}
@end