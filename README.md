# SXPictureCarousel
  图片轮播视图

example:

1.在故事板的自动布局面板中拉个空白View，然后设置custom class为SXPictureCarousel，接着拖根线出来生成属性。

如:  @property (weak, nonatomic) IBOutlet SXPictureCarousel *pictureCarousel;

2.然后设置对象的item属性即可，item属性需要传递PictureCarouselEntity模型。

如:

self.pictureCarousel.items = @[
[PictureCarouselEntity initWithTitleName:@"a" requestUrl:@"http://www.baidu.com/1.jpg"],
[PictureCarouselEntity initWithTitleName:@"b" requestUrl:@"http://www.baidu.com/2.jpg"],
[PictureCarouselEntity initWithTitleName:@"c" requestUrl:@"http://www.baidu.com/3.jpg"]];

备注: 使用代码初始化也支持，代理方法的话大家可以按住command键进去看看哟！
