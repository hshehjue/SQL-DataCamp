/* So far, you implemented three foreign key constraints:

professors.university_id to universities.id
affiliations.organization_id to organizations.id
affiliations.professor_id to professors.id
These foreign keys currently have the behavior ON DELETE NO ACTION. Here, you're going to change that behavior for the column referencing organizations from affiliations. If an organization is deleted, all its affiliations (by any professor) should also be deleted.

Altering a key constraint doesn't work with ALTER COLUMN. Instead, you have to delete the key constraint and then add a new one with a different ON DELETE behavior.

For deleting constraints, though, you need to know their name. This information is also stored in information_schema. */


/* INSTRUCTION (1/4)

Have a look at the existing foreign key constraints by querying table_constraints in information_schema. */

-- Identify the correct constraint name
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY';

/* INSTRUCTION (2/4) 

Delete the affiliations_organization_id_fkey foreign key constraint in affiliations. */

-- Drop the right foreign key constraint
ALTER TABLE affiliations
DROP CONSTRAINT affiliations_organization_id_fkey;


/* INSTRUCTION (3/4) 

Add a new foreign key to affiliations that cascades deletion if a referenced record is deleted from organizations. Name it affiliations_organization_id_fkey. */

-- Add a new foreign key constraint from affiliations to organizations which cascades deletion
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE;


/* INSTRUCTION (4/4)

Run the DELETE and SELECT queries to double check that the deletion cascade actually works. */

-- Delete an organization 
DELETE FROM organizations 
WHERE id = 'CUREM';

-- Check that no more affiliations with this organization exist
SELECT * FROM affiliations
WHERE organization_id = 'CUREM';