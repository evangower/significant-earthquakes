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

# Set mapping for world
worldmap <- fortify(map_data("world"), region = "region")

# Plot map geom
ggplot() +
  geom_map(data = worldmap, map = worldmap, aes(long, lat, map_id = region), fill = "grey80", color = "black", linewidth = 0.25) +
# Plot df with map geom
geom_point(data = df, aes(longitude, latitude, color = "#fd5353"), size = 0.5) +
  scale_color_manual(values = "#fd5353") +
  labs(title = "Earthquakes since 1900",
       subtitle = "Map of every earthquake with a magnitude above 5",
       caption = "Data: Kaggle | Viz: Evan Gower",
       x = "", y = "") +
  theme_minimal() +
  theme(text = element_text(family = "font", size = 10),
        plot.title = element_text(size = 70, face = "bold"),
        plot.subtitle = element_text(size = 40),
        plot.caption = element_text(size = 20, color = "grey45"),
        legend.position = "none",
        axis.text = element_blank(),
        plot.margin = margin(40, 40, 40, 40),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Save plot
ggsave("global-earthquakes-since-1900-map.png", width = 12, height = 8)
