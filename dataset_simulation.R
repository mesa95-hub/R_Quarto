library(dplyr)
library(tidyr)
install.packages("writexl")
library(writexl)
set.seed(123)  # Reproducibility
n <- 1000

# Product categories
products <- c("Tomato_Sauce", "Pasta", "Sliced_Bread", "Grated_Cheese", "Spreadable_Cheese", "Tuna", "Coffee")

data <- data.frame(ID = 1:n)
for (prod in products) {
  data[[paste0("purchase_", prod)]] <- sample(1:7, n, replace = TRUE)
  data[[paste0("consumption_", prod)]] <- sample(1:7, n, replace = TRUE)
  data[[paste0("environment_respect_", prod)]] <- sample(1:7, n, replace = TRUE)
  data[[paste0("brand_", prod)]] <- sample(1:6, n, replace = TRUE)
  for (pkg in 1:6) {
    data[[paste0("bws_packaging_", prod, "_", pkg)]] <- sample(c(-1, 0, 1), n, replace = TRUE)
  }
  data[[paste0("bws_product_", prod)]] <- sample(-1000:1000, n, replace = TRUE)
}

data$label_attention <- sample(1:5, n, replace = TRUE)

data$label_1 <- sample(0:1, n, replace = TRUE)
data$label_2 <- sample(0:1, n, replace = TRUE)
data$label_3 <- sample(0:1, n, replace = TRUE)
data$label_4 <- sample(0:1, n, replace = TRUE)

for (q in 1:5) {
  data[[paste0("GW_1_", q)]] <- sample(1:7, n, replace = TRUE)
  data[[paste0("GW_2_", q)]] <- sample(1:7, n, replace = TRUE)
}
for (q in 1:3) {
  data[[paste0("GPI_1_", q)]] <- sample(1:7, n, replace = TRUE)
  data[[paste0("GPI_2_", q)]] <- sample(1:7, n, replace = TRUE)
}

for (q in 1:12) {
  data[[paste0("FCQ_", q)]] <- sample(1:7, n, replace = TRUE)
}
for (q in 1:6) {
  data[[paste0("ENVKNW_", q)]] <- sample(1:7, n, replace = TRUE)
}
for (q in 1:5) {
  data[[paste0("TRUST_", q)]] <- sample(1:7, n, replace = TRUE)
}
for (q in 1:5) {
  data[[paste0("GPA_", q)]] <- sample(1:7, n, replace = TRUE)
}
for (q in 1:3) {
  data[[paste0("EXP_", q)]] <- sample(1:7, n, replace = TRUE)
}
for (q in 1:3) {
  data[[paste0("INV_", q)]] <- sample(1:7, n, replace = TRUE)
}
for (q in 1:3) {
  data[[paste0("SKP_", q)]] <- sample(1:7, n, replace = TRUE)
}

data$gender <- sample(c("F", "M", "NR"), n, replace = TRUE)
data$age <- sample(18:80, n, replace = TRUE)
data$area <- sample(c("North", "Center", "South", "Islands"), n, replace = TRUE)
data$family_size <- sample(1:6, n, replace = TRUE)
data$education <- sample(c("Elementary", "Middle", "HighSchool", "Degree", "Postgraduate"), n, replace = TRUE)
data$job <- sample(c("Student", "Farmer", "Craftsman", "Employee", "Teacher", "Entrepreneur",
                     "Retailer", "Freelancer", "Manager", "Worker", "Homemaker",
                     "Retired", "Unemployed", "Other"), n, replace = TRUE)
data$work_environment <- sample(c("Directly_related", "Indirectly_related", "Not_related", "Don't_know", "Unemployed"), n, replace = TRUE)

# Income-related items
for (q in 1:3) {
  data[[paste0("INC_", q)]] <- sample(1:7, n, replace = TRUE)
}

# Export to Excel
write_xlsx(data, path = "questionnaire_dataset_simulation.xlsx")

