using { mhp.capire.carshop as my } from '../db/schema';

service AdminService @(requires:'authenticated-user') {
  entity Cars as projection on my.Cars;
  entity Manufactures as projection on my.Manufacturers;
  entity Orders as select from my.Orders;
}


extend service AdminService with {
  entity OrderItems as select from my.OrderItems;
}

// Restrict access to orders to users with role "admin"
 annotate AdminService.Orders with  @( restrict: [
   { grant: 'UPDATE', to: 'admin' }, 
   { grant: 'CREATE', to: 'admin' }, 
   { grant: 'READ', to: 'admin' }, 
  ]);
@odata.draft.enabled
  annotate AdminService.Cars with {
    price @Measures.Unit : currency_code @Measures.ISOCurrency : 'currency_code';

  }
