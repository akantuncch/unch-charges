# libraries
library(tidyverse);
library(ggplot2);

# scripts
# source("utils.R");

# combine data 
df_distinct <- df_percent %>%
  select(year, charge_description, percent_change, price) %>%
  filter(year == "2021") %>%
  select(!year) %>%
  distinct()

df_slice <- bind_rows(
  df_distinct %>% slice_min(percent_change, n=10, with_ties = FALSE),
  df_distinct %>% slice_max(percent_change, n=10, with_ties = FALSE)
)

# prepare data
df_plot <- df_slice %>% 
  mutate(mycolor = ifelse(percent_change>0, "type1", "type2")) %>%
  # tibble::rownames_to_column(var = "index") %>%
  arrange(desc(percent_change), .by_group = TRUE)

# plot data
ggplot(data = df_plot, aes(charge_description, percent_change)) +
  geom_hline(
    yintercept = 100,
    colour = "red",
    size = 0.7,
    alpha = 0.35, 
    linetype = "dashed"
  ) +
  geom_hline(
    yintercept = 200,
    colour = "red",
    size = 0.7,
    alpha = 0.35, 
    linetype = "dashed"
  ) +
  geom_hline(
    yintercept = 0,
    colour = "darkgrey",
    size = 0.7,
    alpha = 1
  ) +
  geom_segment(
    aes(
      x = charge_description,
      xend = charge_description,
      y = 0,
      yend = percent_change,
      color = mycolor
    ),
    size = 9,
    alpha = 1,
  ) +
  scale_y_continuous(labels = scales::percent_format(scale = 1), expand = expansion(mult = c(.05, NA))) +
  geom_label(
    aes(label = charge_description),
    alpha = 0,
    hjust = "inward",
    # position = position_stack(vjust = 0),
    size = 4.5,
    label.size = 0,
    label.padding = unit(0.2, "lines")) +
  geom_text(
    aes(label = scales::dollar(price)),
    hjust = "outward"
  ) +
  theme_ipsum_rc() +
  labs(
    title = "Top/Bottom 10 Pricing Changes for Healthcare Services",
    subtitle = "UNC Medical Center | July 2022",
    x = "",
    y = "Relative Percent Change 2022-2021 (%) | Listed Cost 2022 ($)",
    caption = "Source | UNC Health"
  ) +
  theme(
    plot.margin = margin(15, 40, 8, 8),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.title.x = element_text(hjust=0, vjust = -0.2),
    axis.ticks.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position = "none",
    panel.border = element_blank()) +
  coord_flip(clip = "off") +
  guides(fill = guide_legend(override.aes = list(alpha = 1))
  )

# ggsave("images/charge-movers22.png", bg = "white")
# ggsave("images/charge-movers22.png", bg = "white", width = 10, height = 10, units = "in", dpi = 300)