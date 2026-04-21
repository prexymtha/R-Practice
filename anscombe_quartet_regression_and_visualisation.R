# Install and load pacman if not available
if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}

library(pacman)

# Load required libraries
p_load(tidyverse, texreg)



# 1. DATA: Anscombe's Quartet (1973)

# Load built-in dataset and convert to tibble
anscombe_df <- as_tibble(datasets::anscombe)

# Inspect structure of data
glimpse(anscombe_df)


# 2. SUMMARY STATISTICS

# Compute mean and standard deviation for each variable
anscombe_summary <- anscombe_df %>%
  summarise(
    across(
      everything(),
      list(
        mean = ~mean(.),
        sd   = ~sd(.)
      )
    )
  )

anscombe_summary


# 3. REGRESSION MODELS

# Fit separate linear models
model_x1_y1 <- lm(y1 ~ x1, data = anscombe_df)
model_x2_y2 <- lm(y2 ~ x2, data = anscombe_df)
model_x3_y3 <- lm(y3 ~ x3, data = anscombe_df)
model_x4_y4 <- lm(y4 ~ x4, data = anscombe_df)



# 4. MODEL TABLE OUTPUT
modelresults <- knitreg(
  list(model_x1_y1, model_x2_y2, model_x3_y3, model_x4_y4),
  custom.model.names = c("Model: y1 ~ x1", "Model: y2 ~ x2", "Model: y3 ~ x3", "Model: y4 ~ x4"),
  caption = "Linear regressions for Anscombe subsets",
  caption.above = TRUE
)

# 5. VISUALISATION


# Plot 1: x1 vs y1
plot_x1_y1 <- ggplot(anscombe_df, aes(x = x1, y = y1)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship between x1 and y1",
    x = "x1",
    y = "y1"
  )

plot_x1_y1


# Plot 2: x2 vs y2
plot_x2_y2 <- ggplot(anscombe_df, aes(x = x2, y = y2)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship between x2 and y2",
    x = "x2",
    y = "y2"
  )

plot_x2_y2

# Plot 3: x3 vs y3
plot_x3_y3 <- ggplot(anscombe_df, aes(x = x3, y = y3)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship between x3 and y3",
    x = "x3",
    y = "y3"
  )

plot_x3_y3

# Plot 4: x4 vs y4
plot_x4_y4 <- ggplot(anscombe_df, aes(x = x4, y = y4)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship between x4 and y4",
    x = "x4",
    y = "y4"
  )

plot_x4_y4


