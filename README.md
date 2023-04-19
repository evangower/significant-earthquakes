# Significant Earthquakes Summary
This project provides an analysis of global earthquakes with magnitude above 5. I dive into timing of earthquakes and the March 2011 earthquakes that affected Japan.

## Understand Earthquakes
Earthquakes are a natural phenomena that can cause significant damage to infrastructure and pose threats to human safety. 

Excerpt from [Wikipedia:](https://en.wikipedia.org/wiki/Earthquake)

> Earthquakes are caused mostly by rupture of geological faults but also by other events such as volcanic activity, landslides, mine blasts, and nuclear tests. An earthquake's point of initial rupture is called its hypocenter or focus. The epicenter is the point at ground level directly above the hypocenter.

## Data Collection
The dataset is sourced from the United States Geological Survey [(USGS)](https://www.usgs.gov/programs/earthquake-hazards/earthquakes), which maintains a global catalog of earthquake information. The dataset includes earthquakes from all regions of the world, from the most seismically active regions like the Pacific Ring of Fire to less active regions like Europe and Africa.

## Visualizations

### [Earthquakes since 1900](https://github.com/evangower/significant-earthquakes/blob/main/code/global-eathquakes-since-1900-map.R)
Map of every earthquake with a magnitude above 5 since 1900. Somme countries are alomst covered in earthquake points.

![plot](https://github.com/evangower/significant-earthquakes/blob/main/plots/global-earthquakes-since-1900-map.png)

### [Timing of Earthquakes](https://github.com/evangower/significant-earthquakes/blob/main/code/timing-of-significant-earthquakes.R)
Most earthquakes happen during winter/early spring and the afternoon/evening hours of the day.

![plot](https://github.com/evangower/significant-earthquakes/blob/main/plots/earthquakes-per-month.png)
![plot](https://github.com/evangower/significant-earthquakes/blob/main/plots/earthquakes-per-hour.png)

### [Number of Monthly Earthquakes](https://github.com/evangower/significant-earthquakes/blob/main/code/timing-of-significant-earthquakes.R)
Early on it was rare to see a month have over 200 earthquakes. But once the 70's hit, that number changed and we have seen months consistently be above that bar. Most notably March 2011 saw the highest amount of monthly earthquakes.

![plot](https://github.com/evangower/significant-earthquakes/blob/main/plots/monthly-earthquakes-by-year-tile-chart.png)

### [March 2011](https://github.com/evangower/significant-earthquakes/blob/main/code/march-2011-earthquakes.R)
In March 2011 there were a astounding 694 earthquakes with a magnitude above 5 hit, with 281 hitting March 11 alone. 

![plot](https://github.com/evangower/significant-earthquakes/blob/main/plots/march-2011-earthquakes.png)

In the early morning on March 11, 2011, Japan experienced the strongest earthquake in its recorded history. The 9.1 magnitude earthquake struck below the North Pacific, 130 kilometers (81 miles) east of Sendai, the largest city in the Tohoku region, a northern part of the island of Honshu.

From [National Geographic](https://education.nationalgeographic.org/resource/tohoku-earthquake-and-tsunami/)

> The Tohoku earthquake caused a tsunami. A tsunami—Japanese for “harbor wave”—is a series of powerful waves caused by the displacement of a large body of water. Most tsunamis, like the one that formed off Tohoku, are triggered by underwater tectonic activity, such as earthquakes and volcanic eruptions. The Tohoku tsunami produced waves up to 40 meters (132 feet) high, More than 450,000 people became homeless as a result of the tsunami. More than 15,500 people died. The tsunami also severely crippled the infrastructure of the country.

![plot](https://github.com/evangower/significant-earthquakes/blob/main/plots/march-11-2011-earthquakes.png)
![plot](https://github.com/evangower/significant-earthquakes/blob/main/plots/japan-earthquakes-map.png)
![plot](https://github.com/evangower/significant-earthquakes/blob/main/plots/japan-earthquakes-by-hour-map.png)
