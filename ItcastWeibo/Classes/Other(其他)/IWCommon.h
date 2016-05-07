// 0.账号相关
#define IWAppKey @"2699927613"
#define IWAppSecret @"737ea9bf1343d91d039315b070c2d36f"
#define IWRedirectURI @"http://digtime.cn"
#define IWLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", IWAppKey, IWRedirectURI]

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define IWLog(...) NSLog(__VA_ARGS__)
#else
#define IWLog(...)
#endif

// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 5.微博cell上面的属性
/** 昵称的字体 */
#define IWStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define IWRetweetStatusNameFont IWStatusNameFont

/** 时间的字体 */
#define IWStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define IWStatusSourceFont IWStatusTimeFont

/** 正文的字体 */
#define IWStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define IWRetweetStatusContentFont IWStatusContentFont

/** 表格的边框宽度 */
#define IWStatusTableBorder 5

/** cell的边框宽度 */
#define IWStatusCellBorder 10

// 6.微博cell内部相册
#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10