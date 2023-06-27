using { mhp.capire.carshop as my } from '../db/schema';

service AdminService @(requires:'authenticated-user') {
 
  
   entity Cars     as projection on  my.Cars {
      *,
      enginePowerKw * 1.35962 as enginePowerPS : Integer @title : '{i18n>enginePowerPS}'   @Core.Computed @Measures.Unit: '{i18n>HP}' @Measures.ISOCurrency : 'HP',
    
    }
    excluding {
      createdBy,
      modifiedBy
    };
  entity Orders as select from my.Orders;
  
  
  entity Manufacturers as projection on my.Manufacturers;
  entity OrderItems as select from my.OrderItems;

}


// Restrict access to orders to users with role "admin"
 annotate AdminService.Orders with  @( restrict: [
   { grant: 'UPDATE', to: 'admin' }, 
   { grant: 'CREATE', to: 'admin' }, 
   { grant: 'READ', to: 'admin' }, 
  ]);

  


