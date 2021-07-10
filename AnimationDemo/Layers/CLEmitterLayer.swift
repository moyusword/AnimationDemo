//
//  CLEmitterLayer.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/7.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

class CLEmitterLayer: CAEmitterLayer {
    
    /// emitterCells  装着CAEmitterCell对象的数组，被用于把粒子投放到layer上
    /// birthRate  粒子产生系数
    /// lifetime  存在时长
    /// emitterPosition  发射位置
    /// emitterZPosition  发射源的z坐标位置
    /// emitterSize  发射源的尺寸大小
    /// emitterDepth  决定粒子形状
    /// emitterShape  粒子发射源的形状
    /// emitterMode  粒子发射模式
    /// renderMode  渲染模式
    /// velocity  粒子速度
    /// scale  粒子的缩放比例
    /// spin  自旋转速度
    /// seed  用于初始化随机数产生的种子
    
    //烟花粒子特效
    static func showFireworks(_ view: UIView) {
        //分为3种粒子，子弹粒子，爆炸粒子，散开粒子
        let fireworkEmitter = CLEmitterLayer()
        fireworkEmitter.emitterPosition = CGPoint(x: screenWidth / 2, y: screenHeight)
        fireworkEmitter.emitterSize = CGSize(width: screenWidth / 2, height: 0)
        fireworkEmitter.emitterMode = .outline
        fireworkEmitter.emitterShape = .line
        fireworkEmitter.renderMode = .additive
        fireworkEmitter.seed = (arc4random()%100)+1
        
        // Create the rocket
        let rocket = CAEmitterCell()
        rocket.birthRate = 1.0
        rocket.velocity = 500
        rocket.velocityRange = 100
        rocket.yAcceleration = 75
        rocket.lifetime = 1.02 //发射源存在时长
        //小圆球图片
        rocket.contents = UIImage.init(named: "dot")?.cgImage
        rocket.scale = 0.2
        rocket.color = UIColor.yellow.cgColor
        rocket.greenRange = 1.0 // different colors
        rocket.redRange = 1.0
        rocket.blueRange = 1.0
        rocket.spinRange = CGFloat(Double.pi) // slow spin
        
        //爆炸粒子
        let burst = CAEmitterCell()
        burst.birthRate = 1.0 // at the end of travel
        burst.velocity = 0 //速度为0
        burst.scale = 1 //大小
        burst.redSpeed = -1.5 // shifting
        burst.blueSpeed = 1.5
        burst.greenSpeed = 1.0
        burst.lifetime = 0.35 //存在时间
        
        //爆炸散开粒子
        let spark = CAEmitterCell()
        spark.scale = 0.5
        spark.birthRate = 400
        spark.velocity = 125
        spark.emissionRange = CGFloat(2 * Double.pi) // 360 度
        spark.yAcceleration = 75 // gravity
        spark.lifetime = 3
        //散开的粒子样式
        spark.contents = UIImage.init(named: "dot")?.cgImage
        spark.greenSpeed = -0.1
        spark.redSpeed = 0.4
        spark.blueSpeed = -0.1
        spark.alphaSpeed = -0.25
        spark.spin = CGFloat(2 * Double.pi)
        spark.spinRange = CGFloat(2 * Double.pi)
        
        // 3种粒子组合，可以根据顺序，依次烟花弹－烟花弹粒子爆炸－爆炸散开粒子
        fireworkEmitter.emitterCells = [rocket]
        rocket.emitterCells = [burst]
        burst.emitterCells = [spark]
        
        view.layer.addSublayer(fireworkEmitter)
    }
    
    /*
     CAEmitterCell 属性介绍
     
     CAEmitterCell类代表从CAEmitterLayer射出的粒子
     
     alphaRange：一个粒子的颜色alpha能改变的范围
     
     alphaSpeed：粒子透明度在生命周期内的改变速度
     
     birthrate：粒子参数的速度乘数因子，每秒发射的粒子数量
     
     blueRange：一个粒子的颜色blue能改变的范围
     
     blueSpeed：粒子blue在生命周期内的改变速度
     
     color：粒子的颜色
     
     contents：是个CGImageRef的对象，既粒子要展现的图片
     
     contentsRect：应该画在contents里的子rectangle
     
     emissionLatitude：发射的z轴方向的角度
     
     emissionLongitude：x-y平面的发射方向
     
     emissionRange：周围发射角度
     
     emitterCells：粒子发射的粒子
     
     enabled：粒子是否被渲染
     
     greenrange： 一个粒子的颜色green 能改变的范围
     
     greenSpeed： 粒子green在生命周期内的改变速度
     
     lifetime：生命周期
     
     lifetimeRange：生命周期范围      lifetime= lifetime(+/-) lifetimeRange
     
     magnificationFilter：不是很清楚好像增加自己的大小
     
     minificatonFilter：减小自己的大小
     
     minificationFilterBias：减小大小的因子
     
     name：粒子的名字
     
     redRange：一个粒子的颜色red 能改变的范围
     
     redSpeed：粒子red在生命周期内的改变速度
     
     scale：缩放比例
     
     scaleRange：缩放比例范围
     
     scaleSpeed：缩放比例速度
     
     spin：粒子旋转角度
     
     spinrange：粒子旋转角度范围
     
     style：不是很清楚：
     
     velocity：速度
     
     velocityRange：速度范围
     
     xAcceleration：粒子x方向的加速度分量
     
     yAcceleration：粒子y方向的加速度分量
     
     zAcceleration：粒子z方向的加速度分量
     
     注意：粒子同样有emitterCells属性，也就是说粒子同样可以发射粒子。
     */
    
}
