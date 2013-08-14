### LVYImageViewController

---

LVYImageViewController can be used for single image viewer on full screen.

It provide a placeholder image for preview, then downloading full resolution for display.

 
#### Installation
---

To use LVYImageViewController:

1. Make sure that your project includes [SDWebImage](https://github.com/rs/SDWebImage), a perfect image downloading & caching solution.
2. Copy over the LVYImageViewController folder to your project folder.
3. \#import "LVYImageViewController.h"

#### Example Code
---

    NSString *demoImageUrl = @"http://photo2.bababian.com/upload5/20101105/9FBE2A149D137465EA950DF250EE3DB0.jpg"; // Hope the links is not broken when you try it :)
    LVYImageViewController *ivc = [[LVYImageViewController alloc] initWithPlaceholderImage:[UIImage imageNamed:@"asuka.jpg"] imageUrl:demoImageUrl];
    
    if ([self respondsToSelector:@selector(addChildViewController:)]) {
        [self addChildViewController:ivc];
    }
    [self.view addSubview:ivc.view];
    
    
#### Notes
---

* LVYImageViewController was made with ARC.
* The demo is not well tested.

#### License
---

##### MIT License

Copyright (c) 2013 Levey ([http://golevey.com](http://golevey.com))

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.