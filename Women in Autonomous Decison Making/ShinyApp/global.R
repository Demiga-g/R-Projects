library(tidyverse, quietly=TRUE)


    #  ----- Data Importation, Cleaning, Manipulation, and Selection -----

raw_data <- read.csv("equality_business_law.csv", na="..")[, -c(2, 4)]

clean_1 <- raw_data %>%
  pivot_longer(cols=contains("..YR", ignore.case=FALSE), names_to="year", 
               values_to="values") %>%
  rename(region=Country.Name, variables=Series.Name)%>%
  pivot_wider(., names_from=variables, values_from=values) %>%
  mutate(year=str_sub(year, 2, 5), 
         across(year, as.numeric),
         region=recode(region, 
                       "Cabo Verde" = "Cape Verde", 
                       "Congo, Dem. Rep." = "Democratic Republic of the Congo", 
                       "Congo, Rep." = "Republic of Congo", 
                       "Cote d'Ivoire" = "Ivory Coast",
                       "Egypt, Arab Rep." = "Egypt", 
                       "Gambia, The" = "Gambia", 
                       "Eswatini" = "Swaziland"))

biz_law_1 <- clean_1[, 1:11]
equality_1 <- clean_1[, c(1:2, 12:25)]



#   ----- Cleaning and Manipulating the Women, Business, and the Law Data ---

recode.biz_law <- c("region", "year", "Assets", "Entrepreneurship", 
                    "Marriage", "Mobility", "Parenthood", "Pay", "Pension", 
                    "Workplace", "Overall")

colnames(biz_law_1) <- recode.biz_law
biz_law <- biz_law_1 %>%
  pivot_longer(cols=recode.biz_law[3:11], names_to="indicator", 
               values_to="score")



# ----- Women, Business, and the Law variables to select from when plotting ---

wbl_inds <- unique(biz_law$indicator)
wbl_yrs <- rev(unique(biz_law$year))


# -------- Cleaning and Manipulating the Gender Equality Data --------

recode.equality <- c("region", "year",  "apply for passport",
                     "be head of household", "choose where to live",
                     "get a job", "obtain a judgment of divorce",
                     "open a bank account", "register a business",
                     "sign a contract", "travel outside her home",
                     "travel outside the country", "work at night",
                     "work in job deemed dangerous",
                     "work in an industrial job", "remarry")

colnames(equality_1) <- recode.equality
equality <- equality_1 %>%
  pivot_longer(cols=recode.equality[3:16], names_to="opinion", 
               values_to="response") %>%
  mutate(across(response, ~replace_na(., 3)), 
         across(c(response), factor))



# ----- Gender Equality variables to select from when plotting --------

ge_ops <- unique(equality$opinion)
ge_yrs <- rev(unique(equality$year))



# ----- Selecting only African Continents for Plotting --------- 

continents <- read.csv("africa_clean_coords.csv")
africa_countries <- continents %>%
  filter(Continent == "Africa")

africa_map <- map_data("world", region=africa_countries$Country)



# --------- Defining Labels to use for Women, Business, and Law Map -------

country_labels <- africa_countries %>%
  left_join(plot_indicators, by=c("Country"="region")) %>%
  distinct(Country, .keep_all=TRUE) %>%
  select(-c("long", "lat", "year", "indicator", "score", "Continent")) %>%
  mutate(across(c(country_code), factor)) %>%
  rename(lat=latitude, long=longitude)

