## Redlining & Socio-Economic Outcomes EDA - Data Folder


## What's in the Data Folder?

-`chicago_health_atlas_codebook_final.csv` : codebook for the Chicago Health Atlas dataset 
-`holc_health_combined_data_final.rds` : cleaned and joined dataset that was used 
in all visualizations and analyses 
-`raw/chicago_health_atlas_final.csv` : A dataset from [chicagohealthatlas.org](https://chicagohealthatlas.org/download ) of various socio-economic outcomes for Chicago residents labeled by 2020 neighborhood census tracts. The data comes 
from a variety of sources collected from years ranging from 2015-2023.
-`raw/HOLC_2020_census_tracts.csv`: A dataset from [datadiversitykids.org](https://data.diversitydatakids.org/dataset/holc_census_tracts-home-owner-loan-corporation--holc--neighborhood-grades-for-us-census-tracts/resource/402d2eb0-c096-48d3-bf76-4af66f80953d#dictionary_anchor) that contains Home Owner Loan Corporation (HOLC) neighborhood risk ratings mapped to 2020 census tracks.

## Notable Variables from Clean Dataset

### Original Source: Chicago Health Atlas
-`geoid`: census tract ID
-`rbs_2017_2021`: percent of households spending more than 50% of their income 
on rent
-`chaixyp_2023`: Chicago Environmental Justice Index, composite score reflecting 
pollution in a neighborhood
-`ede_2017_2021`: College graduation rate, percent of residents 25 or older with 
a bachelor's degree or higher 
-`for_2017_2021`: Percent of residents who were not U.S. citizens at time of birth
-`leq_2017_2021`: Percent of residents aged 5 or older who do not speak English "very well"
-`pct_w_2017_2021`: Percent of residents who identify as Non-Hispanic White

### Original Source: HOLC
[Codebook for Raw HOLC dataset](https://data.diversitydatakids.org/dataset/holc_census_tracts-home-owner-loan-corporation--holc--neighborhood-grades-for-us-census-tracts/resource/402d2eb0-c096-48d3-bf76-4af66f80953d#dictionary_anchor)
-`geoid`: census tract ID
-`class`: Neighborhood risk rating assigned by the Home Owner Loan Corporation (HOLC)
in the 1930s mapped to 2020 census tracts. Classes range from A-D with A = "best", B = "still desirable", C = "definitely declining", and D = "hazardous".



