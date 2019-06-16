getwd()
dosebea <- read_excel("meta_data/fibre_doseres.xlsx",sheet="beasley")
dosebea$logRR <- with(dosebea, log(RR))

dosebea$sei <- ((log(dosebea$ci_high)-dosebea$logRR)/1.96)

mod <- dosresmeta(formula = logRR ~ dose, type = "ci", cases = cases,
                  n = tot_n, covariance = "gl", se=sei,
                  data= dosebea)
summary(mod)
# get the RR per 10 g/day
exp(-0.0135)^10 # 0.8737159

# get the lower confidence interval per 10 g/day
exp(-0.0314)^10 # 0.730519

# get the upper confidence interval per 10 g/day
exp(0.0043)^10  #  1.043938


# For fibre and physical activity open ended categories, if the lower limit of the first one is missing then put the lower bound to be ZERO. 

# To calculate the upper bound of a category/quantile add the width of the previous category/quantile i.e. [the upper-lower level/number]
# Then estimate the midpoint by adding the newly calculated upper bound by the lower bound 

# Alternatively to calculate the midpoint directly: 
# lower bound of the top open ended cat/quant+[(upper-lower bound of the previous category)/2]


