# Check and install required packages ####
list.of.packages <- c('readxl',
                      'readr',
                      'ggplot2',
                      'ggpubr',
                      'RColorBrewer',
                      'plyr',
                      'grid',
                      'ggthemes')

new.packages <-
  list.of.packages[!(list.of.packages %in%
                       installed.packages()[, "Package"])]

if (length(new.packages))
  install.packages(new.packages)

lapply(
  list.of.packages,
  FUN = function(list.of.packages) {
    do.call("require", list(list.of.packages))
  }
)

# Load data ####
get_files = list.files(path = "orig_data",
                       pattern = "*.csv",
                       full.names = T)
file_names = sub('orig_data/', '', sub('.csv', '', get_files))

for (i in 1:(length(get_files))) {
  #Import File
  load_file <- read.csv(file = get_files[i])
  
  #Name DF
  df_name <- file_names[i]
  
  #Update DF Name
  assign(paste(df_name), load_file)
}

# Calculate Data ####
mean_age <- mean(general_data$Age)
# Visualization 1: Density Plot for Age ####
fill <- "#4271AE"
line <- "#1F3552"

p1 <- ggplot(general_data, aes(x = Age)) +
  geom_density(fill = fill, colour = line) +
  scale_y_continuous(name = "Density") +
  ggtitle("Density Plot of Employee Age") +
  theme_economist() +
  theme(legend.position = "bottom", legend.direction = "horizontal",
        legend.box = "horizontal",
        legend.key.size = unit(1, "cm"),
        plot.title = element_text(family="Tahoma"),
        text = element_text(family = "Tahoma"),
        axis.title = element_text(size = 12),
        legend.text = element_text(size = 9),
        legend.title=element_text(face = "bold", size = 9))
p1

