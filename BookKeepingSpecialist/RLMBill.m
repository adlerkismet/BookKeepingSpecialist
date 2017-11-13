//
//  RLMBill.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/4.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "RLMBill.h"

@implementation RLMBill
+ (nullable NSString *)primaryKey{
    return @"id";
}

- (double)currentValueFromValue:(double)value expenseType:(ExpensesType)type{
    if (type == ExpensesTypePayment) {
        return -fabs(value);
    } else {
        return fabs(value);
    }
}

- (NSString*)typeDescription{
    switch (self.type.type) {
        case BillTypeBook:
            return @"书本";
            break;
        case BillTypeCar:
            return @"汽车";
            break;
        case BillTypeCashGift:
            return @"礼金";
            break;
        case BillTypeChild:
            return @"孩子";
            break;
        case BillTypeClothes:
            return @"衣服";
            break;
        case BillTypeCommunication:
            return @"通讯";
            break;
        case BillTypeDailyNecessities:
            return @"日用品";
            break;
        case BillTypeDigital:
            return @"电子产品";
            break;
        case BillTypeDonate:
            return @"捐赠";
            break;
        case BillTypeElder:
            return @"孝敬老人";
            break;
        case BillTypeEntertainment:
            return @"娱乐";
            break;
        case BillTypeFruits:
            return @"水果";
            break;
        case BillTypeFurniture:
            return @"家具";
            break;
        case BillTypeGift:
            return @"礼物";
            break;
        case BillTypeHairDressing:
            return @"美容美发";
            break;
        case BillTypeHousing:
            return @"房屋";
            break;
        case BillTypeLiquor:
            return @"烟酒";
            break;
        case BillTypeLottery:
            return @"彩票";
            break;
        case BillTypeMaintain:
            return @"维修";
            break;
        case BillTypeMedical:
            return @"医疗";
            break;
        case BillTypeOffice:
            return @"办公用品";
            break;
        case BillTypePet:
            return @"宠物";
            break;
        case BillTypeRestaurant:
            return @"餐饮";
            break;
        case BillTypeShopping:
            return @"购物";
            break;
        case BillTypeSnacks:
            return @"甜品";
            break;
        case BillTypeSocial:
            return @"社交";
            break;
        case BillTypeSports:
            return @"运动";
            break;
        case BillTypeStudy:
            return @"学习";
            break;
        case BillTypeTransportation:
            return @"交通";
            break;
        case BillTypeTravel:
            return @"旅行";
            break;
        case BillTypeVegetable:
            return @"蔬菜";
            break;
        case BillTypeFinance:
            return @"金融理财";
            break;
        case BillTypeMoney:
            return @"其他收入";
            break;
        case BillTypePartTimeJob:
            return @"兼职收入";
            break;
        case BillTypeSalary:
            return @"薪水";
            break;
        case BillTypeDefault:
            return @"默认";
            break;
        case BillTypeSetting:
            return @"设置";
            break;
            
        default:
            return nil;
            break;
    }
    
}

- (NSString*)typeDescriptionFromType:(BillType)type{
    switch (type) {
        case BillTypeBook:
            return @"书本";
            break;
        case BillTypeCar:
            return @"汽车";
            break;
        case BillTypeCashGift:
            return @"礼金";
            break;
        case BillTypeChild:
            return @"孩子";
            break;
        case BillTypeClothes:
            return @"衣服";
            break;
        case BillTypeCommunication:
            return @"通讯";
            break;
        case BillTypeDailyNecessities:
            return @"日用品";
            break;
        case BillTypeDigital:
            return @"电子产品";
            break;
        case BillTypeDonate:
            return @"捐赠";
            break;
        case BillTypeElder:
            return @"孝敬老人";
            break;
        case BillTypeEntertainment:
            return @"娱乐";
            break;
        case BillTypeFruits:
            return @"水果";
            break;
        case BillTypeFurniture:
            return @"家具";
            break;
        case BillTypeGift:
            return @"礼物";
            break;
        case BillTypeHairDressing:
            return @"美容美发";
            break;
        case BillTypeHousing:
            return @"房屋";
            break;
        case BillTypeLiquor:
            return @"烟酒";
            break;
        case BillTypeLottery:
            return @"彩票";
            break;
        case BillTypeMaintain:
            return @"维修";
            break;
        case BillTypeMedical:
            return @"医疗";
            break;
        case BillTypeOffice:
            return @"办公用品";
            break;
        case BillTypePet:
            return @"宠物";
            break;
        case BillTypeRestaurant:
            return @"餐饮";
            break;
        case BillTypeShopping:
            return @"购物";
            break;
        case BillTypeSnacks:
            return @"甜品";
            break;
        case BillTypeSocial:
            return @"社交";
            break;
        case BillTypeSports:
            return @"运动";
            break;
        case BillTypeStudy:
            return @"学习";
            break;
        case BillTypeTransportation:
            return @"交通";
            break;
        case BillTypeTravel:
            return @"旅行";
            break;
        case BillTypeVegetable:
            return @"蔬菜";
            break;
        case BillTypeFinance:
            return @"金融理财";
            break;
        case BillTypeMoney:
            return @"其他收入";
            break;
        case BillTypePartTimeJob:
            return @"兼职收入";
            break;
        case BillTypeSalary:
            return @"薪水";
            break;
        case BillTypeDefault:
            return @"默认";
            break;
        case BillTypeSetting:
            return @"设置";
            break;
            
        default:
            return nil;
            break;
    }
    
}

@end
