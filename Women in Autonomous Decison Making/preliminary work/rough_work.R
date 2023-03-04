
        
  # ------- First Exploration --------
    

# Turning Data into surveydata object

library(surveydata, quietly=TRUE)
library(likert)
require(maps)

women_vs_men <- females_wider[, c(1:15)] 
questions <- colnames(women_vs_men)
colnames(women_vs_men) <- c("country", paste0("Q_", 1:14))
colnames(women_vs_men)

varlabels(women_vs_men) <- questions
women_vs_men <- as.surveydata(women_vs_men, renameVarlabel=TRUE)

p1 <- survey_plot_yes_no(women_vs_men, "Q_2")
p1
women_vs_men
membersurvey
as.surveydata(females_wider)
survey_plot_yes_no(as.surveydata(females_wider), `A woman can apply for a passport in the same way as a man (1=yes; 0=no)`)


map(database="world", region="Democratic Republic of the Congo")
map(database="world", region=c("Republic of Congo"))

  

          # --------- Second Exploration -------


females <- read.csv("women_autonomous_decisions.csv", na.strings="..")

females_narrower <- females[, c(1, 3, 4, 7)]
colnames(females_narrower) <- c("name", "region", "code", "response")
females_narrower$region[females_narrower$region == "Congo, Dem. Rep."] <- 
  "Democratic Republic of the Congo"

females_wider <- pivot_wider(females_narrower, names_from=name, 
                             values_from=response)

women_vs_men <- females_wider[, c(1:16)]
colnames(women_vs_men) <- c("region", "code", paste0("Q_", 1:15))
women_vs_men[, ] <- lapply(women_vs_men[,], factor)

east_africa <- map_data("world", region=unique(women_vs_men$region))
east_data <- left_join(women_vs_men, east_africa, by=c("region"))

labels <- east_data %>%
  group_by(code, group) %>%
  summarise(long=mean(long), lat=mean(lat)) %>%
  distinct(code, group, .keep_all=TRUE)

labels <- labels[-c(3,6,9:11), ]

ggplot(east_data, aes(x=long, y=lat, group=group))+
  coord_fixed(1.5)+
  geom_polygon(aes(fill=Q_1), color="#ffefdb")+
  scale_fill_manual(values=c("#0b84a5", "#f17853"), labels=(c("No", "Yes")), 
                    name="Equality in Passport Application")+
  ggrepel::geom_label_repel(aes(label= code), data= labels, 
                            size=2.5, max.overlaps = 50, label.size=0, 
                            arrow=arrow(length=unit(0.1, 'cm'))) +
  labs(caption=paste0("Data Source: World Bank\n", "Author: Midega George Last Update 2023/01/31"))+
  theme(axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        rect=element_blank(),
        axis.line = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_rect(fill = "antiquewhite2"),
        legend.position="bottom", legend.title=element_text(size=10))


library(maps)

world <- map_data("world")
continents <- read.csv("countries-continents.csv")

continents %>%
  filter(Continent == "Africa") %>%
  left_join(world, by=c("Country"="region")) %>%
  distinct(Country, .keep_all=TRUE)


unique_av <- world %>%
  group_by(region) %>%
  distinct(region, .keep_all=TRUE)

map(database = "world", region=africa_countries$Country)


#coords <- read.csv("countries_coordinates.csv")
#labels <- left_join(world, coords, by=c("region"="country"))[, -c(1, 2)]
#labels <- left_join(equality, labels, by=c("Region"="region"))

#labels <- labels %>%
# rename(lat=latitude, long=longitude) %>%
# group_by(`Region code`, group) %>%
# distinct(`Region code`, group, .keep_all=TRUE)


coords <- read.csv("countries_coordinates.csv")

a <- continents %>%
  left_join(coords, by=c("Country"="country"))

#write.csv(a, "africa_clean_coords.csv", row.names=FALSE)




      # ----------- Third Exploration -----------

library(tidyverse, quietly=TRUE)
library(scales)



raw_data <- read.csv("yearly_progression.csv")[, -c(4)]
clean_1 <- raw_data %>%
  pivot_longer(cols=contains("..YR", ignore.case=FALSE), names_to="year", 
               values_to="values") %>%
  rename(region=Country.Name, `region code`=Country.Code, 
         variables=Series.Name)%>%
  pivot_wider(., names_from=variables, values_from=values) %>%
  mutate(year=str_sub(year, 2, 5))%>%
  mutate_at(c('year'), as.numeric)

equality1 <- clean_1[, 1:17]
health1 <- clean_1[, c(1:3, 18, 19, 22, 21, 20)]
visits1 <- clean_1[, c(1:3, 23:26, 32)]
purchases1 <- clean_1[, c(1:3, 27:31)]
participation1 <- clean_1[, c(1:3, 35, 36, 34, 37, 39, 40, 38)]



## Participation

"Percentage of women participating in decisions regarding "
recode.participation <- c("region", "region code", "year", 
                          "what food to cook daily", 
                          "daily purchases",
                          "visits to family, relative, and friends",
                          "major household purchases", 
                          "their own health care", 
                          "all the three decisions", 
                          "none of the three decisions")

colnames(participation1) <- recode.participation

participation <- participation1 %>%
  pivot_longer(cols=recode.participation[4:10], names_to="decisions", 
               values_to="percentage")

participation %>%
  filter(year==1990, decisions=="what food to cook daily")



"Decision maker about a woman's own health care: "
recode.health <- c("region", "region code", "year", "mainly husband", 
                   "mainly wife", "wife and husband jointly", "someone else", 
                   "other")

colnames(health1) <- recode.health

health <- health1 %>%
  pivot_longer(cols=recode.health[4:8], names_to="decisions", 
               values_to="percentage")

all_decisions <- health %>%
  filter(year==2020, decisions=="wife and husband jointly")


# Data to Plot
plot_decisions <- africa_map %>%
  left_join(all_decisions, by=c("region"))

# Labels to use

country_labels <- africa_countries %>%
  left_join(plot_decisions, by=c("Country"="region")) %>%
  distinct(Country, .keep_all=TRUE) %>%
  select(-c("long", "lat")) %>%
  rename(lat=latitude, long=longitude)


# Cape verde, Congos, Egypt, Gambia, Cote'dvore, Eswatini

count_a <- unique(raw_data$Country.Name)
count_b <- unique(africa_countries$Country)
setdiff(count_a, count_b)



# Map Plot

ggplot(plot_decisions, aes(x=long, y=lat, group=group))+
  coord_fixed(1)+
  geom_polygon(aes(fill=percentage), color="#ffefdb")+
  #scale_fill_manual(values=c("#0b84a5", "#f17853", "#ffb600"), 
  #                  labels=(c("No", "Yes", "No Data")), 
  #                  name=unique(all_response$opinion)) +
  labs(title=paste0("A woman can ", {unique(all_decisions$decisions)}, 
                    " the same way as a man, ", {unique(all_decisions$year)}), 
       caption=paste0("Data Source: World Bank\n", "Last Update 2023/01/31\n", 
                      "Author: Midega George")) +
  ggrepel::geom_label_repel(aes(label= country_code), data= country_labels, 
                            size=2.5, max.overlaps = 25, label.size=0, 
                            arrow=arrow(length=unit(0.1, 'cm'))) +
  theme(axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        rect=element_blank(),
        axis.line = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_rect(fill = "#b1d3bc"),
        plot.title = element_text(hjust = 0.5),
        legend.position="right", legend.title=element_text(size=10), 
        legend.text=element_text(size=10))


# Health

females <- read.csv("women_autonomous_decisions.csv", na.strings="..")

females_narrower <- females[, c(1, 3, 4, 7)]
females_narrower

colnames(females_narrower) <- c("name", "region", "code", "response")
females_narrower$region[females_narrower$region == "Congo, Dem. Rep."] <- 
  "Democratic Republic of the Congo"

females_wider <- pivot_wider(females_narrower, names_from=name, 
                             values_from=response)

females_wider
women_vs_men <- females_wider[, c(1:16)]
colnames(women_vs_men) <- c("region", "code", paste0("Q_", 1:15))
women_vs_men[, ] <- lapply(women_vs_men[,], factor)

females_wider[, c(100, 99, 94, 95)]



# Shiny Rough Work

#dashboardSidebar(
#  sidebarMenu(
#    id = "sidebar",
#    menuItem(text="Women, Business, and Law", tabName="WBL", icon=icon("female")),
#    conditionalPanel("input.sidebar == 'WBL' && input.tab_1 == 'map_1'", selectInput("indicators", label="Indicator", choices=wbl_inds)),
#   conditionalPanel("input.sidebar == 'WBL' && input.tab_1 == 'map_1'", selectInput("wbl_years", label="Year", choices=wbl_yrs)),
#    menuItem(text="Gender Equality", tabName="GE", icon=icon("balance-scale")),
#    conditionalPanel("input.sidebar == 'GE' && input.tab_2 == 'map_2'", selectInput("opinions", label="Opinion", choices=ge_ops)),
#    conditionalPanel("input.sidebar == 'GE' && input.tab_2 == 'map_2'", selectInput("ge_years", label="Year", choices=ge_yrs))
#  )
#),
