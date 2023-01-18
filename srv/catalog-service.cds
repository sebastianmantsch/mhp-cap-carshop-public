using mhp.capire.carshop as my from '../db/schema';

service CatalogService @(path:'/browse') {

  @readonly 
  entity Cars as SELECT from my.Cars { *, 
    manufacturer.name as manufacturer } 
  excluding {createdBy, modifiedBy};
 

  //@readonly
  //entity Manufacturers as projection on my.Manufacturers;

  //@readonly entity ListOfCars as select distinct model from Cars as model;
  
@odata.draft.enabled
  entity Orders as select from my.Orders;


  entity OrderItems as select from my.OrderItems;

  entity Customer as select from my.Orders.customer;

  annotate Cars with {
    price @Measures.Unit : currency_code @Measures.ISOCurrency : 'currency_code';
  }

 
}
