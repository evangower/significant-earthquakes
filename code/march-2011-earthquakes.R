library(tidyverse)
library(maps)
library(ggfortify)
library(showtext)

# Add custom font
font_add_google("Outfit", "font")
showtext_auto()

# Read data file
df <- read_csv("Significant_Earthquakes.csv")

# Drop rows containing NA for longitude and latitude
df <- df %>%
  drop_na(longitude, latitude)

# Create function to retrive year/month/date
getDate <- function(x, pos1, pos2){
  val <- substr(strsplit(as.character(x), 'T')[[1]][1],pos1, pos2)
  return(as.numeric(val))
}

# Create new date, time columns
df$year <- sapply(df$time, getDate, 1, 4)
df$month <- sapply(df$time, getDate, 6, 7)
df$day <- sapply(df$time, getDate, 9, 10)

df <- df %>%
  mutate(hour = strftime(df$time, "%H"))

# Create mymonths
mymonths <- c("January", "February", "March",
              "April", "May", "June",
              "July", "August", "September",
              "October", "November", "December")

# Create month name column
df$month_name <- mymonths[ df$month ]

# Order months
df$ordered_month <- factor(df$month_name, levels = month.name)

# Set mapping for world
worldmap <- fortify(map_data("world"), region = "region")

# Summarize monthly earthquakes in March of 2011
march_2011_quakes <- df %>%
  filter(year == 2011 & ordered_month == "March") %>%
  group_by(day) %>%
  summarize(count = n())

# Plot number of earthquakes by day in March 2011
ggplot(march_2011_quakes, aes(day, count)) +
  geom_col(fill = "#ff6f6f") +
  scale_x_continuous(breaks = seq(3, 30, 3)) +
  labs(title = "March 2011 Earthquakes",
       subtitle = "Number of earthquakes with a magnitude above 5 hit in March 2011",
       caption = "Data: Kaggle | Viz: Evan Gower",
       x = "",
       y = "Number of earthquakes") +
  theme_minimal() +
  theme(text = element_text(family = "font"),
        plot.title = element_text(size = 50, face = "bold"),
        plot.subtitle = element_text(size = 25),
        plot.caption = element_text(size = 16, color = "grey45"),
        axis.title = element_text(size = 22),
        axis.text = element_text(size = 16),
        plot.margin = margin(20, 40, 20, 40),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank()) +
  annotate(geom = "text", x = 13, y = 260, label = "March 11, 2011 had 281 earthquakes,\nby far the most of any day.",
           size = 9, lineheight = 0.3, hjust = 0, vjust = 0, family = "font")

# Save March 2011 plot
ggsave("march-2011-earthquakes.png", width = 9, height = 6)

# Filter for earthquakes on March 11, 2011
march_11_2011_quakes <- df %>%
  filter(year == 2011 & ordered_month == "March" & day == 11)

# Create mycolors
mycolors <- c("#ffd9d9", "#fd9696", "#ff6f6f", "#fd5353", "#ce0303")

# Create plot of earthquakes on March 11, 2011
ggplot(march_11_2011_quakes, aes(time, mag)) +
  geom_bar(aes(color = mag), stat = "identity", width = 0.5) +
  scale_color_gradientn(colors = mycolors) +
  labs(title = "Earthquakes on March 11, 2011",
      subtitle = "Chart of the earthquakes thatoccured on March 11, 2011",
      caption = "Data: Kaggle | Viz: Evan Gower",
      x = "",
      y = "",
      color = "Magnitude of earthquake") +
  theme_minimal() +
  theme(text = element_text(family = "font"),
        plot.title = element_text(size = 50, face = "bold"),
        plot.subtitle = element_text(size = 25),
        plot.caption = element_text(size = 16, color = "grey45"),
        legend.position = "bottom",
        legend.title = element_text(size = 20),
        legend.text = element_text(size = 16),
        axis.text = element_text(size = 16),
        plot.margin = margin(20, 40, 20, 40),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank()) +
  annotate(geom = "text", x = as.POSIXct('2011-03-11 3:30:00'), y = 8.85, label = "Highest Quake at 9.1",
           size = 8, family = "font") +
  guides(color = guide_colorbar(label.position = "bottom",
                               title.position = "top",
                               title.hjust = 0.5,
                               title.vjust = -1,                           barwidth = unit(15, "lines"),
                               barheight = unit(0.4, "lines")))

# Save March 11, 2011 earthquakes plot
ggsave("march-11-2011-earthquakes.png", width = 9, height = 6)

# Create frame for next two plots
frame <- ggplot() +
  geom_map(data = worldmap, map = worldmap, aes(long, lat, map_id = region), fill = "grey80", color = "black", linewidth = 0.25) +
  geom_point(data = march_11_2011_quakes, aes(longitude, latitude, color = mag), size = 2, alpha = 0.5) +
  scale_color_gradientn(colors = mycolors) +
  xlim(132, 148) +
  ylim(30, 45) +
  theme_minimal() +
  theme(text = element_text(family = "font", size = 10),
        plot.title = element_text(size = 50, face = "bold"),
        plot.subtitle = element_text(size = 25),
        plot.caption = element_text(size = 16, color = "grey45"),
        legend.position = "bottom",
        legend.title = element_text(size = 22),
        legend.text = element_text(size = 16),
        axis.text = element_blank(),
        plot.margin = margin(40, 40, 40, 40),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  guides(color = guide_colorbar(label.position = "bottom",
                                title.position = "top",
                                title.hjust = 0.5,
                                title.vjust = -1,
                                barwidth = unit(15, "lines"),
                                barheight = unit(0.4, "lines")))

# Map March 11, 2011 earthquakes
frame + labs(title = "Earthquakes on March 11, 2011",
                 subtitle = "Hundreds of earthquakes with a magnitude above 5 struck Japan",
                 caption = "Data: Kaggle | Viz: Evan Gower",
                 x = "",
                 y = "",
                 color = "Magnitude of earthquake")

# Save japan earthquakes plot
ggsave("japan-earthquakes-map.png", width = 7, height = 8)

# Now map by hour
frame + facet_wrap(~ hour) +
  labs(title = "Earthquakes by Hour on March 11, 2011",
       caption = "Data: | Viz: Evan Gower",
       x = "",
       y = "",
       color = "Magnitude of earthquake") +
  theme(strip.text = element_text(family = "font"))

# Save japan earthquakes by hour map
ggsave("japan-earthquakes-by-hour-plot", width = 7, height = 8)
