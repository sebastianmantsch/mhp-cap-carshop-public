using mhp.capire.carshop as my from '../db/schema';

service CatalogService @(path:'/browse') {

  @readonly 
  entity Cars as SELECT from my.Cars { *, 
    manufacturer.name as manufacturer } 
  excluding {createdBy, modifiedBy};

  //@readonly
  //entity Manufacturers as projection on my.Manufacturers;

  //@readonly entity ListOfCars as select distinct model from Cars as model;
  

  annotate Cars with {
    price @Measures.Unit : currency_code @Measures.ISOCurrency : 'currency_code';

  }

 
}
