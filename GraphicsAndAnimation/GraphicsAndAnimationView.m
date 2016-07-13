//
//  GraphicsAndAnimationView.m
//  GraphicsAndAnimation
//
//  Created by boolean on 16/7/8.
//  Copyright © 2016年 boolean. All rights reserved.
//

#import "GraphicsAndAnimationView.h"
#import "UtilsMacro.h"

@interface GraphicsAndAnimationView ()
{
    SEL selector;
}
@end

@implementation GraphicsAndAnimationView

- (void)drawRect:(CGRect)rect
{
    if (selector)
    {
        IMP imp = [self methodForSelector:selector];
        void (*func)(id,SEL) = (void *)imp;
        func(self,selector);
    }
}
#pragma mark - Getter And Setter
- (void)setTitle:(NSString *)title
{
    _title = title;
    if ([title isEqualToString:@"绘制文本"])
    {
        selector = @selector(drawText);
    }
    else if ([title isEqualToString:@"绘制图像"])
    {
        selector = @selector(drawImage);
    }
    else if ([title isEqualToString:@"构造可伸缩图片"])
    {
        selector = @selector(drawResizableImage);
    }
    else if ([title isEqualToString:@"画线"])
    {
        selector = @selector(drawLine);
    }
    else if ([title isEqualToString:@"构造路径"])
    {
        selector = @selector(createPath);
    }
    else if ([title isEqualToString:@"绘制矩形"])
    {
        selector = @selector(drawRectangle);
    }
    else if ([title isEqualToString:@"为形状增加阴影"])
    {
        selector = @selector(drawShadow);
    }
    else if ([title isEqualToString:@"绘制渐变"])
    {
        selector = @selector(drawGradient);
    }
    else if ([title isEqualToString:@"移动图形环境上所绘制的形状"])
    {
        selector = @selector(affineTransform);
    }
    else if ([title isEqualToString:@"缩放绘制到图形环境上的形状"])
    {
        selector = @selector(scaleTransform);
    }
    else if ([title isEqualToString:@"旋转绘制在图形环境上的形状"])
    {
        selector = @selector(rotationTransform);
    }
}

#pragma mark - Method
- (void)drawText
{
    UIColor *magentaColor =[UIColor redColor];
    UIFont *font = [UIFont fontWithName:@"IowanOldStyle-BoldItalic"
                                   size:30];
    NSString *str = @"I Learn Really Fast";
    [str drawInRect:CGRectMake(20, 100, 100, 200)
     withAttributes:@{NSFontAttributeName:font,
                      NSForegroundColorAttributeName:magentaColor}];
    //    [str drawAtPoint:CGPointMake(20, 200)
    //      withAttributes:@{NSFontAttributeName:font,
    //                       NSForegroundColorAttributeName:magentaColor}];
}

- (void)drawImage
{
    UIImage *img = [UIImage imageNamed:@"123.png"];
    [img drawInRect:CGRectMake(20, 200, 100, 200)];
}
- (void)drawResizableImage
{
    UIImage *img = [[UIImage imageNamed:@"1"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 8, 5)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 81, 200, 100)];
    imgView.image = img;
    
    [self addSubview:imgView];
}

- (void)drawLine
{
    [self drawRooftopAtTopPointof:CGPointMake(160.0f, 80.0f) textToDisplay:@"Miter"
                         lineJoin:kCGLineJoinMiter];
    [self drawRooftopAtTopPointof:CGPointMake(160.0f, 220.0f) textToDisplay:@"Bevel"
                         lineJoin:kCGLineJoinBevel];
    [self drawRooftopAtTopPointof:CGPointMake(160.0f, 360.0f) textToDisplay:@"Round"
                         lineJoin:kCGLineJoinRound];
}
- (void) drawRooftopAtTopPointof:(CGPoint)paramTopPoint
                   textToDisplay:(NSString *)paramText
                        lineJoin:(CGLineJoin)paramLineJoin
{
    //设置线的颜色
    [[UIColor brownColor] set];

    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //设置接合点
    CGContextSetLineJoin(currentContext, paramLineJoin);
    //设置线的宽度
    CGContextSetLineWidth(currentContext, 20);
    //设置起点
    CGContextMoveToPoint(currentContext,paramTopPoint.x - 140,paramTopPoint.y + 100);
    //在这个点结束
    CGContextAddLineToPoint(currentContext,paramTopPoint.x,paramTopPoint.y);
    //将线延伸到另一个点
    CGContextAddLineToPoint(currentContext,paramTopPoint.x + 140,paramTopPoint.y + 100);
    //使用上下文的当前颜色绘制这条线
    CGContextStrokePath(currentContext);

    [[UIColor blackColor] set];
    CGPoint drawingPoint = CGPointMake(paramTopPoint.x - 40.0f, paramTopPoint.y + 60.0f);
    [paramText drawAtPoint:drawingPoint
            withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]}];
}

- (void)createPath
{
    //创建path
    CGMutablePathRef path = CGPathCreateMutable();
    //path起点
    CGPathMoveToPoint(path, NULL, 0, 0);
    //
    CGPathAddLineToPoint(path, NULL, SCREEN_WIDTH, SCREEN_HEIGHT);
    //
    CGPathMoveToPoint(path, NULL, SCREEN_WIDTH, 0);
    //
    CGPathAddLineToPoint(path, NULL, 0, SCREEN_HEIGHT);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(currentContext, path);
    
    [[UIColor blueColor] setStroke];
    //kCGPathStroke
    //画线来标记路径的边界或边缘,使用选中的绘图色。
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
}

- (void)drawRectangle
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rectangle1 = CGRectMake(10.0f, 80.0f, 200.0f, 300.0f);
    
    CGRect rectangle2 = CGRectMake(40.0f, 170.0f, 90.0f, 300.0f);

    CGRect rectangles[2] = {rectangle1,rectangle2};

    CGPathAddRects(path, NULL, (const CGRect *)&rectangles, 2);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext, 5.0);
    CGContextAddPath(currentContext, path);
    
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];

    [[UIColor blackColor] setStroke];
    
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    CGPathRelease(path);
}

- (void) drawRectAtTopOfScreen
{
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //保存当前图形上下文状态
    CGContextSaveGState(currentContext);
    
    CGContextSetShadowWithColor(currentContext, CGSizeMake(10.0f, 10.0f), 20.0f, [[UIColor grayColor] CGColor]);
    
    /* Create the path first. Just the path handle. */
    CGMutablePathRef path = CGPathCreateMutable();
    
    /* Here are the rectangle boundaries */
    CGRect firstRect = CGRectMake(55.0f, 100.0f, 150.0f, 150.0f);
    
    /* Add the rectangle to the path */
    CGPathAddRect(path,NULL,firstRect);
    
    /* Add the path to the context */
    CGContextAddPath(currentContext, path);
    
    /* Set the fill color to cornflower blue */
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    
    /* Fill the path on the context */
    CGContextDrawPath(currentContext, kCGPathFill);
    
    /* Dispose of the path */
    CGPathRelease(path);
    
    //恢复当前图形上下文状态
    CGContextRestoreGState(currentContext);
}


- (void) drawRectAtBottomOfScreen
{
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef secondPath = CGPathCreateMutable();
    
    CGRect secondRect = CGRectMake(150.0f, 300.0f, 100.0f,100.0f);
    
    CGPathAddRect(secondPath,NULL,secondRect);
    
    CGContextAddPath(currentContext, secondPath);
    
    [[UIColor purpleColor] setFill];
    
    CGContextDrawPath(currentContext, kCGPathFill);
    
    CGPathRelease(secondPath);
    
}
- (void)drawShadow
{
    [self drawRectAtTopOfScreen];
    [self drawRectAtBottomOfScreen];
}

- (void)drawGradient
{
    //创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //指定渐变的开始和结束颜色
    UIColor *startColor = [UIColor blueColor];
    CGFloat *startColorComponents = (CGFloat *)CGColorGetComponents(startColor.CGColor);
    UIColor *endColor = [UIColor greenColor];
    CGFloat *endColorComponents = (CGFloat *)CGColorGetComponents(endColor.CGColor);
    
    //颜色组件的数组
    CGFloat colorComponents[8] = {
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3],
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3],
    };
    
    //颜色数组中的颜色位置
    CGFloat colorIndices[2] = {
        0.0,
        1.0
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                                 (const CGFloat *)colorComponents,
                                                                 (const CGFloat *)colorIndices,
                                                                 2);

    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint ,endPoint;
    startPoint = CGPointMake(120, 260);
    endPoint = CGPointMake(200.0f, 220);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
}

/**
 *  移动图形环境上所绘制的形状
 */
- (void)affineTransform
{
    CGAffineTransform transform = CGAffineTransformMakeTranslation(100, 0);

    [self transformWithT:transform];
}

- (void)scaleTransform
{
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self transformWithT:transform];
}
- (void)rotationTransform
{
    CGAffineTransform transform = CGAffineTransformMakeRotation(45*M_PI/180.0);
    [self transformWithT:transform];
}
- (void)transformWithT:(CGAffineTransform )transform
{
    //创建一个新的 CGMutablePathRef 类型的可变路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectrangle = CGRectMake(10.0, 80, 200, 300);
    
    //向路径添加一个矩形
    CGPathAddRect(path, &transform, rectrangle);
    //获取当前图形上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //向图形环境上添加一个路径
    CGContextAddPath(currentContext, path);
    
    UIColor *color = [UIColor colorWithRed:0.20f
                                     green:0.60f
                                      blue:0.80f
                                     alpha:1.0f];
    //设置填充颜色为浅蓝色
    [color setFill];
    //将笔触颜色设置为棕色
    [[UIColor brownColor] setStroke];
    //设置线的宽度
    CGContextSetLineWidth(currentContext, 5.0);
    //在图形上下文绘制路径
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    //释放路径所分配的内存
    CGPathRelease(path);
}

- (void)drawRect:(CGRect)rect
{
    /* Create the path first. Just the path handle. */
    CGMutablePathRef path = CGPathCreateMutable();
    
    /* Here are the rectangle boundaries */
    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f,  300.0f);
    
    /* Add the rectangle to the path */
    CGPathAddRect(path,  NULL, rectangle);
    
    /* Get the handle to the current context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    /* Save the state of the context to revert
     back to how it was at this state, later */
    CGContextSaveGState(currentContext);
    
    /* Translate the current transformation matrix to the right by 100 points */
    CGContextTranslateCTM(currentContext, 100.0f,  0.0f);
    
    /* Add the path to the context */
    CGContextAddPath(currentContext, path);
    
    /* Set the fill color to cornflower blue */
    [[UIColor colorWithRed:0.20f
                     green:0.60f
                      blue:0.80f
                     alpha:1.0f] setFill];
    
    /* Set the stroke color to brown */
    [[UIColor brownColor] setStroke];
    
    /* Set the line width (for the stroke) to 5 */
    CGContextSetLineWidth(currentContext,
                                                                                                           5.0f);
    /* Stroke and fill the path on the context */
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    /* Dispose of the path */
    CGPathRelease(path);
    
    /* Restore the state of the context */
    CGContextRestoreGState(currentContext);
}
@end
