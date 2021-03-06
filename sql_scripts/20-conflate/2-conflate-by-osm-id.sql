DROP TABLE IF EXISTS same_osm_id;


CREATE TABLE same_osm_id (
    id serial primary key,
    place_ids varchar(10000),
    osm_id varchar(107),
    admin_level smallint,
    instance_count int
);


INSERT INTO same_osm_id (place_ids, osm_id, admin_level, instance_count)
SELECT array_to_string(array_agg(id), ','), osm_id, admin_level, count(*)
FROM places
WHERE osm_id IS NOT NULL AND osm_id != ''
GROUP BY osm_id, admin_level;


DELETE FROM same_osm_id WHERE instance_count = 1;


SELECT count(*) from same_osm_id; 


SELECT count(*) AS num_places from places;


SELECT count(conflate_places_by_ids(place_ids)) FROM same_osm_id;


SELECT count(*) AS num_places from places;


DELETE
FROM places
WHERE id IN (SELECT unnest(string_to_array(string_agg(place_ids, ','), ',')::bigint[]) FROM same_osm_id);


SELECT count(*) AS num_places from places;