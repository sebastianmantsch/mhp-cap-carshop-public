using mhp.capire.carshop as my from '../db/schema';

service CatalogService @(path : '/browse') {

  @readonly
  entity Cars          as
    select from my.Cars {
      *,
      enginePowerKw * 1.35962 as enginePowerPS : Integer  @title : '{i18n>enginePowerPS}'  @Core.Computed  @Measures.Unit : '{i18n>HP}'  @Measures.ISOCurrency : 'HP',
    }
    excluding {
      createdBy,
      modifiedBy
    };

  @readonly
  entity Models        as
    select from Cars distinct {
      key model,
          manufacturer,
          enginePowerKw,
          enginePowerPS,
          engineType,
    };

  @readonly
  entity Manufacturers as projection on my.Manufacturers;

  //@readonly entity ListOfCars as select distinct model from Cars as model;

  @odata.draft.enabled
  entity Orders        as select from my.Orders;


  entity OrderItems    as select from my.OrderItems;
  entity Customer      as select from my.Customer;

  annotate Cars with {
    @Common.ValueListWithFixedValues : true
    @Common.ValueList                : {
      $Type          : 'Common.ValueListType',
      CollectionPath : 'Cars',
      Parameters     : [{
        $Type             : 'Common.ValueListParameterInOut',
        ValueListProperty : 'model',
        LocalDataProperty : model
      }, ],
    } model;
  }

}
