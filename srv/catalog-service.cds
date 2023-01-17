using mhp.capire.carshop as my from '../db/schema';

service CatalogService @(path:'/browse') {

  @readonly 
  entity Cars as SELECT from my.Cars { *, 
    manufacturer.name as manufacturer } 
  excluding {createdBy, modifiedBy};

  //@readonly
  //entity Manufacturers as projection on my.Manufacturers;

  //@readonly entity ListOfCars as select distinct model from Cars as model;
  
  @requires: 'authenticated-user'
  entity Orders as Select from my.Orders, my.OrderItems{
    @Core.Computed
    sum(OrderItems.amount) as total: Integer
  }  where OrderItems.parent.OrderNo = Orders.OrderNo;

 annotate Orders  with @odata.draft.enabled;
 
 
}
