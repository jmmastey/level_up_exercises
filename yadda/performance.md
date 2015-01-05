## Troubleshooting Performance with ![Explain](https://31.media.tumblr.com/tumblr_mdjf2gVItN1qih9gi.gif)

Recent Score Output:

```
 HashAggregate  (cost=4921.92..5046.04 rows=9929 width=6)
   Group Key: ratings.beer_id
   ->  Seq Scan on ratings  (cost=0.00..4172.00 rows=149985 width=6)
         Filter: (created_at > (now() - '6 mons'::interval))
```
