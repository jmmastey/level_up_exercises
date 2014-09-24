DROP VIEW IF EXISTS tot_beer_scores;
DROP VIEW IF EXISTS avg_beer_scores;
DROP VIEW IF EXISTS top_rated_beer_per_brewery;
DROP VIEW IF EXISTS recent_avg_score;
DROP VIEW IF EXISTS you_might_also_enjoy;

CREATE VIEW tot_beer_scores AS
    SELECT b.brewery_id, b.id as beer_id, SUM(rating) as total
    FROM ratings INNER JOIN beers b
    ON b.id = ratings.beer_id
    GROUP by b.id;

CREATE VIEW avg_beer_scores AS
    SELECT
        b.brewery_id,
        b.id as beer_id,
        ROUND(AVG(rating), 1) as average
    FROM ratings INNER JOIN beers b
    ON b.id = ratings.beer_id
    GROUP by b.id;

CREATE VIEW top_rated_beer_per_brewery AS
    SELECT
        br.name as brewery_name,
        br.city as brewery_city,
        b.name as beer_name,
        scores.total as score_total
    FROM (
        SELECT brewery_id, beer_id, total, rank()
        OVER (
            PARTITION BY brewery_id ORDER BY total DESC
        )
        FROM tot_beer_scores
    ) scores
    INNER JOIN breweries br
    ON br.id = scores.brewery_id
    INNER JOIN beers b
    ON b.id = scores.beer_id
    WHERE scores.rank = 1
    ORDER BY brewery_name, brewery_city, beer_name;

CREATE VIEW recent_avg_score AS
    SELECT
        br.name as brewery_name,
        br.city as brewery_city,
        b.name as beer_name,
        recent_average.avg_rating
    FROM (
        SELECT beer_id, ROUND(AVG(rating), 1) as avg_rating
        FROM ratings
        WHERE created_at > CURRENT_DATE - INTERVAL '6 months'
        GROUP BY (beer_id)
    ) recent_average
    INNER JOIN beers b
        ON b.id = recent_average.beer_id
    INNER JOIN breweries br
        ON br.id = b.brewery_id
    ORDER BY brewery_name, brewery_city, beer_name;

CREATE VIEW you_might_also_enjoy AS
    SELECT bs.style as style, b.name as beer_name, abs.average
    FROM avg_beer_scores abs
    INNER JOIN beers b
        ON b.id = abs.beer_id
    INNER JOIN beer_styles bs
        ON bs.id = b.beer_style_id
    WHERE abs.average >= 4;
