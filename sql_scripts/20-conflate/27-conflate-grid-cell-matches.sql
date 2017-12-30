/* Conflate places that have almost exactly same lat-long and are not places */
WITH conflated AS (
SELECT (
  SELECT (
    NULL, /* admin1code */
    NULL, /* admin2code */
    NULL, /* admin3code */
    NULL, /* admin4code */
    NULL, /* admin_level */
    longest(asciiname), /* asciiname */
    uniq(alternate_names), /* alternate_names */
    uniq(attribution), /* attribution */
    longest(city), /* city */
    longest(county), /* county */
    longest(country), /* country */
    longest(country_code), /* country_code */
    max(dem), /* dem */
    longest(display_name), /* should we recompute instead? */
    max(elevation), /* elevation */
    max(east)::text, /* east */
    most_popular(geoname_feature_class), /* combine? */
    most_popular(geoname_feature_code), /* combine? */
    first(geonameid), /* combine? */
    first(geo_tag_id), /* combine? */
    most_popular(grid_cell_1_degree), /* recompute? */
    most_popular(grid_cell_5_degrees), /* recompute? */
    most_popular(grid_cell_10_degrees), /* recompute? */
    bool_or(has_admin_level),
    bool_or(has_population),
    max(importance),
    first(latitude), /* just pick first one.. really should do most popular */
    first(longitude), /* just pick first one */
    longest(name), /* should get most popular */
    longest(name_en), /* recalculate? */
    longest(name_en_unaccented), /* recalculate? */
    longest(normalized_name), /* recalculate? */
    max(north),
    most_popular(osmname_class), /* ?? */
    uniq(osmname_id), /* smash? */
    most_popular(osmname_type),
    most_popular(osm_type),
    first(osm_id),
    max(place_rank),
    most_popular(place_type),
    most_popular(point), /* really should get closest to centroid */
    most_popular(point_4),
    max(population),
    min(south),
    most_popular(state),
    most_popular(street),
    most_popular(timezone),
    min(west),
    uniq(wikidata),
    first(wikipageid),
    uniq(wikititle),
    uniq(wikiurl)
  )::conflated_place
  FROM places WHERE id = ANY(string_to_array(place_ids, ',')::int[])
)::conflated_place AS r
FROM normalized_name_cell_counts
)
/*
INSERT INTO places (
  admin1code,           admin2code,
  admin3code,           admin4code,
  admin_level,          asciiname,
  alternate_names,      attribution,
  city,                 county,
  country,              country_code,
  dem,                  display_name,
  elevation,            east,
  geoname_feature_class,geoname_feature_code,
  geonameid,            geo_tag_id,
  grid_cell_1_degree,   grid_cell_5_degrees,
  grid_cell_10_degrees, has_admin_level,
  has_population,       importance,
  latitude,             longitude,
  name,                 name_en,
  name_en_unaccented,   normalized_name,
  north,                osmname_class,
  osmname_id,           osmname_type,
  osm_type,             osm_id,
  place_rank,           place_type,
  point,                point_4,
  population,           south,
  state,                street,
  timezone,             west,
  wikidata,             wikipageid,
  wikititle,            wikiurl
)*/

SELECT
  (r).*
FROM conflated;


/* Delete Old Records that have been merged */
/*DELETE FROM places WHERE id IN (SELECT unnest(string_to_array(string_agg(place_ids, ','), ',')::int[]) FROM matches_within_11_meters);
*/