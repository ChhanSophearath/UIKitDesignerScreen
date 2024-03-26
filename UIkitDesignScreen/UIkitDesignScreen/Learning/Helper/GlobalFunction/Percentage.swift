//
//  Percentage.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 3/2/24.
//

import Foundation

func percentageDouble(fraction:Double, totale: Double)->Double{
    let percentage = (fraction/totale) * 100
    return percentage
}

func percentageInt(fraction:Int, totale: Int)->Int{
    let percentage = (fraction/totale) * 100
    return percentage
}
