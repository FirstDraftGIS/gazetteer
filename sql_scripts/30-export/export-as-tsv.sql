COPY places TO '/tmp/unum.tsv' DELIMITER E'\t' CSV HEADER;


COPY (
    SELECT
    id,
    admin1code
    admin2code,
    admin3code,
    admin4code,
    admin_level,
    asciiname,
    alternate_names,
    attribution,
    city,
    county,
    country,
    country_code,
    dem,
    display_name,
    elevation,
    east,
    geoname_feature_class,
    geoname_feature_code,
    geonameid,
    geo_tag_id,
    importance,
    latitude,
    longitude,
    name,
    name_en,
    north,
    osmname_class,
    osmname_id,
    osmname_type,
    osm_type,
    osm_id,
    place_rank,
    place_type,
    point,
    population,
    south,
    state,
    street,
    timezone,
    west,
    wikidata,
    enwiki_title
    FROM places
)
TO '/tmp/unum.tsv'
DELIMITER E'\t'
CSV
HEADER;
