
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
