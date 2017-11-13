//
//  BillType.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/3.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "AddBillType.h"

@implementation AddBillType
- (id)initWithType:(BillType)type typeName:(NSString*)typeName{
    if (self == [super init]) {
        self.type = type;
        self.typeName = typeName;
    }
    return self;
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

@end
