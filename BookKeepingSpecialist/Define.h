//
//  Define.h
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/6.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef Define_h
#define Define_h
typedef NS_ENUM(NSUInteger,BillType) {
    BillTypeBook,
    BillTypeCar,
    BillTypeCashGift,
    BillTypeChild,
    BillTypeClothes,
    BillTypeCommunication,
    BillTypeDailyNecessities,
    BillTypeDigital,
    BillTypeDonate,
    BillTypeElder,
    BillTypeEntertainment,
    BillTypeFruits,
    BillTypeFurniture,
    BillTypeGift,
    BillTypeHairDressing,
    BillTypeHousing,
    BillTypeLiquor,
    BillTypeLottery,
    BillTypeMaintain,
    BillTypeMedical,
    BillTypeOffice,
    BillTypePet,
    BillTypeRestaurant,
    BillTypeShopping,
    BillTypeSnacks,
    BillTypeSocial,
    BillTypeSports,
    BillTypeStudy,
    BillTypeTransportation,
    BillTypeTravel,
    BillTypeVegetable,
    BillTypeFinance,
    BillTypeMoney,
    BillTypePartTimeJob,
    BillTypeSalary,
    BillTypeDefault,
    BillTypeSetting,
    BillTypeNumMax,
};

typedef NS_ENUM(NSUInteger,PaymentType) {
    PaymentTypeBook,
    PaymentTypeCar,
    PaymentTypeCashGift,
    PaymentTypeChild,
    PaymentTypeClothes,
    PaymentTypeCommunication,
    PaymentTypeDailyNecessities,
    PaymentTypeDigital,
    PaymentTypeDonate,
    PaymentTypeElder,
    PaymentTypeEntertainment,
    PaymentTypeFruits,
    PaymentTypeFurniture,
    PaymentTypeGift,
    PaymentTypeHairDressing,
    PaymentTypeHousing,
    PaymentTypeLiquor,
    PaymentTypeLottery,
    PaymentTypeMaintain,
    PaymentTypeMedical,
    PaymentTypeOffice,
    PaymentTypePet,
    PaymentTypeRestaurant,
    PaymentTypeShopping,
    PaymentTypeeSnacks,
    PaymentTypeSocial,
    PaymentTypeSports,
    PaymentTypeStudy,
    PaymentTypeTransportation,
    PaymentTypeTravel,
    PaymentTypeVegetable,
    PaymentTypeSetting,
};

typedef NS_ENUM(NSUInteger,IncomeType) {
    IncomeTypeCashGift,
    IncomeTypeFinance,
    IncomeTypeMoney,
    IncomeTypePartTimeJob,
    IncomeTypeSalary,
    IncomeTypeSetting,
};

typedef NS_ENUM(NSUInteger,ExpensesType) {
    ExpensesTypePayment,
    ExpensesTypeIncome,
};

typedef NS_ENUM(NSUInteger,TimePeriodType) {
    TimePeriodTypeWeek,
    TimePeriodTypeMonth,
    TimePeriodTypeYear,
};

#endif /* Define_h */
