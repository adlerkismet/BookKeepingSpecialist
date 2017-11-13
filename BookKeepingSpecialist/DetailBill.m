//
//  DetailBill.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/1.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "DetailBill.h"

@implementation DetailBill
- (id)initWithType:(BillType)type date:(NSString*)date typeName:(NSString*)typeName value:(NSNumber*)value{
    if (self == [super init]) {
        self.type = type;
        self.date = date;
        self.typeName = typeName;
        self.value = value;
    }
    return self;
}

- (UIImage*)typeImage{
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
@end
