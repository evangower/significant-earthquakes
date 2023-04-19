library(tidyverse)
library(showtext)

# Add custom font
font_add_google("Outfit", "font")
showtext_auto()

# Read data file
df <- read_csv("Significant_Earthquakes.csv")

# Create function to retrive year/month/day
getDate <- function(x, pos1, pos2){
  val <- substr(strsplit(as.character(x), 'T')[[1]][1], pos1, pos2)
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

# Add month name column
df$month_name <- mymonths [ df$month ]

# Order months
df$ordered_month <- factor(df$month_name, levels = month.name)

# Summarize earthquake count by year, month
monthly_quakes <- df %>%
  group_by(year, ordered_month) %>%
  summarize(count = n())

# Summarize earthquake count by year, hour
hourly_quakes <- df %>%
  group_by(year, hour) %>%
  summarize(count = n())

# Plot number of quakes by month
ggplot(monthly_quakes, aes(ordered_month, count)) +
  geom_col(width = 0.5, fill = "#ff6f6f", color = "#ff6f6f") +
  labs(title = "Earthquakes per Month",
       subtitle = "March sees the highest amount of earthquakes occur by month. Fall seems to see the fewest by season.",
       caption = "Data: Kaggle | Viz: Evan Gower",
       x = "Month",
       y = "Number of Earthquakes") +
  theme_minimal() +
  theme(text = element_text(family = "font"),
        plot.title = element_text(size = 50, face = "bold", vjust = 0.2),
        plot.subtitle = element_text(size = 25, vjust = 1),
        plot.caption = element_text(size = 16, color = "grey45"),
        axis.title = element_text(size = 20),
        axis.text = element_text(size = 13),
        plot.margin = margin(20, 40, 20, 40),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank())

# Save month plot
ggsave("earthquakes-per-month.png", width = 9, height = 6)

# Plot number of quakes by hour
ggplot(hourly_quakes, aes(hour, count)) +
  geom_col(width = 0.5, fill = "#ff6f6f", color = "#ff6f6f") +
  labs(title = "Earthquakes per Hour",
       subtitle = "The afternoon and evening hours see more earthquakes than the morning",
       caption = "Data: Kaggle | Viz: Evan Gower",
       x = "Hour",
       y = "Number of Earthquakes") +
  theme_minimal() +
  theme(text = element_text(family = "font"),
        plot.title = element_text(size = 50, face = "bold", vjust = 0.2),
        plot.subtitle = element_text(size = 25, vjust = -1),
        plot.caption = element_text(size = 16, color = "grey45"),
        axis.title = element_text(size = 20),
        axis.text = element_text(size = 13),
        plot.margin = margin(20, 40, 20, 40),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank())

# Save hour plot
ggsave("earthquakes-per-hour.png", width = 9, height = 6)

# Set colors/breaks for next plot
mybreaks <- c(50, 100, 200, 400, 600)
mycolors <- c("#ffd9d9", "#fd9696", "#ff6f6f", "#fd5353", "#ce0303")

# Plot monthly eaurthquakes by year
ggplot(monthly_quakes, aes(ordered_month, year)) +
  geom_tile(aes(fill = count), color = "white") +
  scale_y_continuous(breaks = c(1920, 1960, 2000)) +
  scale_fill_gradientn(colors = mycolors, breaks = mybreaks, labels = mybreaks, guide = "legend") +
  labs(title = "Number of Monthly Earthquakes",
       subtitle = "Tile chart of the number of global earthquakes per month by year since 1900",
       caption = "Data: Kaggle | Viz: Evan Gower",
       fill = "Number of earthquakes") +
  theme_minimal() +
  theme(text = element_text(family = "font"),
        plot.title = element_text(size = 50, face = "bold"),
        plot.subtitle = element_text(size = 25),
        plot.caption = element_text(size = 16, color = "grey45"),
        legend.position = "bottom",
        legend.title = element_text(size = 20),
        axis.title = element_blank(),
        axis.text = element_text(size = 13),
        plot.margin = margin(20, 40, 20, 40),
        panel.grid = element_blank()) +
  guides(fill = guide_colorbar(label.position = "bottom",
                               title.position = "top",
                               title.hjust = 0.5,
                               title.vjust = -1,
                               barwidth = unit(15, "lines"),
                               barheight = unit(0.4, "lines")))

# Save montly earthquakes by year plot
ggsave("monthly-earthquakes-by-year-tile-chart.png", width = 9, height = 6)
         
  