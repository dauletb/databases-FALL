# databases-FALL ENDTERM PROJECT
I constructed the E-R model which give a simulation of a delivery company close to the realistic one. 
It consists of entities such as order, customers ,tracking and so on with respective attributes.
All normal forms were accomplished
Here is one verification:
Lets take 'orders' table. Lack of multivalued attributes completes 1st Normal Form. No composite primary keys so there is no way 2nd Normal Form is defied. Lets take 
a look at non-prime attributes. No functional dependency between price and weight( such as two orders of 200$ cost may weight differently) or vice versa. The same can be said about other 
attributes. 
I created number of curious relationships such as type of packaging which gives info about delivery time and price of orders. Also, while tracking one can observe 
IP-adress of their delivery. On top of that he can convert them to real locations.

