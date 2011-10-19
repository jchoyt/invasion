-- Load language
CREATE LANGUAGE plpgsql;

-- Create function to delete effects when a char dies
CREATE FUNCTION clearEffectsOnDeath() RETURNS trigger AS '
BEGIN
IF NEW.location=-57005 THEN
    DELETE FROM effects WHERE altid=NEW.id;
END IF;
RETURN NEW;
END;
' LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER clearEffectsOnDeath AFTER UPDATE ON alt
  FOR EACH ROW EXECUTE PROCEDURE clearEffectsOnDeath();

insert into location (id, station, message, messagetype) values (-1337, -57005, 'You see bits of your flesh floating around you', 'chalk');


/* CREATE OR REPLACE FUNCTION update_modified_column()
	RETURNS TRIGGER AS $$
	BEGIN
	   NEW.modified = now();
	   RETURN NEW;
	END;
	$$ language 'plpgsql';

CREATE TRIGGER update_customer_modtime BEFORE UPDATE
    ON customer FOR EACH ROW EXECUTE PROCEDURE
    update_modified_column(); */



