--1)
--Large objects(photos,videos,etc) are stored as a binary large object(collection of binary codes
--of the large data) or as a character large object( collection of character data) as an uninterpreted
--data
--2)
--)
CREATE ROLE accountant;
CREATE ROLE administrator;
CREATE ROLE support;
GRANT ALL PRIVILEGES on table transactions to administrator;
GRANT select, update, delete on table transactions to accountant;
GRANT select on table transactions to support;

--)
CREATE USER Daulet1;
CREATE USER Daulet2;
CREATE USER Daulet3;
GRANT administrator to Daulet1;
GRANT accountant to Daulet2;
GRANT support to Daulet3;
--)
GRANT grant to Daulet1;
--)
revoke update on table transactions from Daulet2;
--4)
create type Currency;
ALTER TABLE accounts
ALTER COLUMN currency TYPE Currency;
--5)
--)
CREATE INDEX on accounts(account_id,customer_id);
--)
CREATE INDEX on accounts(currency,balance);
--6)
BEGIN;
UPDATE accounts
SET balance=balance-400 WHERE account_id='RS88012';
UPDATE accounts
SET balance=balance+400 WHERE account_id='NT10204';
SAVEPOINT savep1;
UPDATE accounts
SET balance=balance-500 WHERE account_id='NK90123';
UPDATE accounts
SET balance=balance+500 WHERE account_id='AB10203';
ROLLBACK to savep1;
UPDATE transactions
SET status='commited';
COMMIT;



