//
//  RLMBillType.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/5/13.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "RLMBillType.h"

@implementation RLMBillType
+ (nullable NSString *)primaryKey{
    return @"id";
}

- (UIImage*)selectedTypeImage{
    switch (self.type) {
        case BillTypeBook:
            return [UIImage imageNamed:@"book_selected.png"];
            break;
        case BillTypeCar:
            return [UIImage imageNamed:@"car_selected.png"];
            break;
        case BillTypeCashGift:
            return [UIImage imageNamed:@"cashGift_selected.png"];
            break;
        case BillTypeChild:
            return [UIImage imageNamed:@"child_selected.png"];
            break;
        case BillTypeClothes:
            return [UIImage imageNamed:@"clothes_selected.png"];
            break;
        case BillTypeCommunication:
            return [UIImage imageNamed:@"communication_selected.png"];
            break;
        case BillTypeDailyNecessities:
            return [UIImage imageNamed:@"dailyNecessities_selected.png"];
            break;
        case BillTypeDigital:
            return [UIImage imageNamed:@"digital_selected.png"];
            break;
        case BillTypeDonate:
            return [UIImage imageNamed:@"donate_selected.png"];
            break;
        case BillTypeElder:
            return [UIImage imageNamed:@"elder_selected.png"];
            break;
        case BillTypeEntertainment:
            return [UIImage imageNamed:@"entertainment_selected.png"];
            break;
        case BillTypeFruits:
            return [UIImage imageNamed:@"fruits_selected.png"];
            break;
        case BillTypeFurniture:
            return [UIImage imageNamed:@"furniture_selected.png"];
            break;
        case BillTypeGift:
            return [UIImage imageNamed:@"gift_selected.png"];
            break;
        case BillTypeHairDressing:
            return [UIImage imageNamed:@"hairdressing_selected.png"];
            break;
        case BillTypeHousing:
            return [UIImage imageNamed:@"housing_selected.png"];
            break;
        case BillTypeLiquor:
            return [UIImage imageNamed:@"liquor_selected.png"];
            break;
        case BillTypeLottery:
            return [UIImage imageNamed:@"lottery_selected.png"];
            break;
        case BillTypeMaintain:
            return [UIImage imageNamed:@"maintain_selected.png"];
            break;
        case BillTypeMedical:
            return [UIImage imageNamed:@"medical_selected.png"];
            break;
        case BillTypeOffice:
            return [UIImage imageNamed:@"office_selected.png"];
            break;
        case BillTypePet:
            return [UIImage imageNamed:@"pet_selected.png"];
            break;
        case BillTypeRestaurant:
            return [UIImage imageNamed:@"restaurant_selected.png"];
            break;
        case BillTypeShopping:
            return [UIImage imageNamed:@"shopping_selected.png"];
            break;
        case BillTypeSnacks:
            return [UIImage imageNamed:@"snacks_selected.png"];
            break;
        case BillTypeSocial:
            return [UIImage imageNamed:@"social_selected.png"];
            break;
        case BillTypeSports:
            return [UIImage imageNamed:@"sports_selected.png"];
            break;
        case BillTypeStudy:
            return [UIImage imageNamed:@"study_selected.png"];
            break;
        case BillTypeTransportation:
            return [UIImage imageNamed:@"transportation_selected.png"];
            break;
        case BillTypeTravel:
            return [UIImage imageNamed:@"travel_selected.png"];
            break;
        case BillTypeVegetable:
            return [UIImage imageNamed:@"vegetable_selected.png"];
            break;
        case BillTypeFinance:
            return [UIImage imageNamed:@"finance_selected.png"];
            break;
        case BillTypeMoney:
            return [UIImage imageNamed:@"money_selected.png"];
            break;
        case BillTypePartTimeJob:
            return [UIImage imageNamed:@"part-time_job_selected.png"];
            break;
        case BillTypeSalary:
            return [UIImage imageNamed:@"salary_selected.png"];
            break;
        case BillTypeDefault:
            return [UIImage imageNamed:@"favorite_selected.png"];
            break;
        case BillTypeSetting:
            return [UIImage imageNamed:@"setting_selected.png"];
            break;
        default:
            return nil;
            break;
    }
}


- (UIImage*)typeImage{
    switch (self.type) {
        case BillTypeBook:
            return [UIImage imageNamed:@"book.png"];
            break;
        case BillTypeCar:
            return [UIImage imageNamed:@"car.png"];
            break;
        case BillTypeCashGift:
            return [UIImage imageNamed:@"cashGift.png"];
            break;
        case BillTypeChild:
            return [UIImage imageNamed:@"child.png"];
            break;
        case BillTypeClothes:
            return [UIImage imageNamed:@"clothes.png"];
            break;
        case BillTypeCommunication:
            return [UIImage imageNamed:@"communication.png"];
            break;
        case BillTypeDailyNecessities:
            return [UIImage imageNamed:@"dailyNecessities.png"];
            break;
        case BillTypeDigital:
            return [UIImage imageNamed:@"digital.png"];
            break;
        case BillTypeDonate:
            return [UIImage imageNamed:@"donate.png"];
            break;
        case BillTypeElder:
            return [UIImage imageNamed:@"elder.png"];
            break;
        case BillTypeEntertainment:
            return [UIImage imageNamed:@"entertainment.png"];
            break;
        case BillTypeFruits:
            return [UIImage imageNamed:@"fruits.png"];
            break;
        case BillTypeFurniture:
            return [UIImage imageNamed:@"furniture.png"];
            break;
        case BillTypeGift:
            return [UIImage imageNamed:@"gift.png"];
            break;
        case BillTypeHairDressing:
            return [UIImage imageNamed:@"hairdressing.png"];
            break;
        case BillTypeHousing:
            return [UIImage imageNamed:@"housing.png"];
            break;
        case BillTypeLiquor:
            return [UIImage imageNamed:@"liquor.png"];
            break;
        case BillTypeLottery:
            return [UIImage imageNamed:@"lottery.png"];
            break;
        case BillTypeMaintain:
            return [UIImage imageNamed:@"maintain.png"];
            break;
        case BillTypeMedical:
            return [UIImage imageNamed:@"medical.png"];
            break;
        case BillTypeOffice:
            return [UIImage imageNamed:@"office.png"];
            break;
        case BillTypePet:
            return [UIImage imageNamed:@"pet.png"];
            break;
        case BillTypeRestaurant:
            return [UIImage imageNamed:@"restaurant.png"];
            break;
        case BillTypeShopping:
            return [UIImage imageNamed:@"shopping.png"];
            break;
        case BillTypeSnacks:
            return [UIImage imageNamed:@"snacks.png"];
            break;
        case BillTypeSocial:
            return [UIImage imageNamed:@"social.png"];
            break;
        case BillTypeSports:
            return [UIImage imageNamed:@"sports.png"];
            break;
        case BillTypeStudy:
            return [UIImage imageNamed:@"study.png"];
            break;
        case BillTypeTransportation:
            return [UIImage imageNamed:@"transportation.png"];
            break;
        case BillTypeTravel:
            return [UIImage imageNamed:@"travel.png"];
            break;
        case BillTypeVegetable:
            return [UIImage imageNamed:@"vegetable.png"];
            break;
        case BillTypeFinance:
            return [UIImage imageNamed:@"finance.png"];
            break;
        case BillTypeMoney:
            return [UIImage imageNamed:@"money.png"];
            break;
        case BillTypePartTimeJob:
            return [UIImage imageNamed:@"part-time_job.png"];
            break;
        case BillTypeSalary:
            return [UIImage imageNamed:@"salary.png"];
            break;
        case BillTypeDefault:
            return [UIImage imageNamed:@"favorite.png"];
            break;
        case BillTypeSetting:
            return [UIImage imageNamed:@"setting.png"];
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString*)typeDescription{
    switch (self.type) {
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
