#import "StylePickerOptionView.h"
#import <UIKit/UIImage+Private.h>

@implementation StylePickerOptionView
@synthesize delegate; //synthesise  MyClassDelegate delegate
- (id)initWithFrame:(struct CGRect)arg1 appearanceOption:(unsigned long long)arg2 properties:(NSMutableDictionary*)properties {
    self = [super initWithFrame:arg1];
    if (self) {
        switch (arg2) {
            case 0:
                _properties = properties[@"leftStyle"];
                break;
            case 1:
                _properties = properties[@"rightStyle"];
                break;
        }
        _appearanceOption = arg2;
        [self _configureView];
    }
    return self;
}
-(BOOL)gestureRecognizer:(id)arg1 shouldRecognizeSimultaneouslyWithGestureRecognizer:(id)arg2 {
    return TRUE;
}
-(BOOL)highlighted {
    return self.highlight;
}
-(void)setHighlight:(BOOL)arg1 {
    _highlight = arg1;
    if (_highlight) {
        [UIView animateWithDuration:0.1 animations:^{
            _stackView.alpha = 0.5f;
        }];
    } else {
        [UIView animateWithDuration:0.1 animations:^{
            _stackView.alpha = 1.0f;
        }];
    }
}
-(void)_configureView {
    _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _stackView .translatesAutoresizingMaskIntoConstraints = NO;
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.distribution = UIStackViewDistributionEqualSpacing;
    [self addSubview:_stackView];
        
    [_stackView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [_stackView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;

   // NSBundle *globalBundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/stylepicker.bundle"];
    _previewImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_properties[@"image"]]];
    _previewImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _previewImageView.clipsToBounds = YES;
    _previewImageView.layer.cornerRadius = 5;
    [_stackView addArrangedSubview:_previewImageView];

    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.text = _properties[@"label"];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    [_stackView addArrangedSubview:_label];

    _checkView = [[StyleCheckmarkView alloc] initWithFrame:CGRectZero];
    _checkView.translatesAutoresizingMaskIntoConstraints = NO;
    [_stackView addArrangedSubview:_checkView];
    [_checkView.heightAnchor constraintEqualToConstant:22].active = YES;
    [_checkView.widthAnchor constraintEqualToConstant:22].active = YES;

    _pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_userDidTapOnView:)];
    _pressRecognizer.minimumPressDuration = 0.025; //seconds
    _pressRecognizer.delegate = self;
    [self addGestureRecognizer:_pressRecognizer];
    /*
    switch (_appearanceOption) {
        case 0:
            _label.text = _properties[@"label"];
            //_previewImageView.image = [UIImage imageNamed:_properties[@"leftImage"]];
            break;
        case 1:
            _label.text = _properties[@"label"];
            //_label.text = NSLocalizedStringFromTableInBundle(@"Dark", @"Common", globalBundle, comment);
            //_previewImageView.image = [UIImage imageNamed:@"left-image" inBundle:globalBundle];
            break;
    }*/
}
-(void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (_enabled) {
        _checkView.selected = YES;
    } else {
        _checkView.selected = NO;
    }
}
-(void)_updateViewForCurrentStyle:(unsigned long long)arg1 {
    if (arg1 == _appearanceOption) {
        self.enabled = YES;
        _feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [_feedbackGenerator impactOccurred];
    } else self.enabled = NO;
}
-(void)_userDidTapOnView:(id)arg1 {
    if (_pressRecognizer.state == UIGestureRecognizerStateBegan) {
        self.highlight = YES;

    } else if (_pressRecognizer.state == UIGestureRecognizerStateEnded) {
        if (!_checkView.selected) [self.delegate userDidTapOnAppearanceOptionView:self];   
        self.highlight = NO;
    }
}
@end