/*Execute the following statement:

INSERT INTO professors (firstname, lastname, university_shortname)
VALUES (NULL, 'Miller', 'ETH');
Why does this throw an error? */


/* Because a database constraint is violated. */

INSERT INTO professors (firstname, lastname, university_shortname)
VALUES(NULL, 'MILLER', 'ETH');