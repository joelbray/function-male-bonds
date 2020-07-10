#Model Code

#Title: With a little help from their friends: adaptive benefits of social bonds in adult male chimpanzees
#Authors: Joel Bray, Joseph T. Feldblum, & Ian C. Gilby

#
#All models in this study used the following structure:
#

model.output <- map2stan(
  alist(
    
    rank_change_outcome ~ dnorm(mu, sigma),
    
    mu ~  a + a_id[id] +
      (b_age + b_age_id[id])*prior_age +
      (b_rank + b_rank_id[id])*prior_rank +
      (b_sociality_index + b_sociality_index_id[id])*prior_sociality_index +
      b_rankXage*prior_rank*prior_age +
      b_rankXsociality_index*prior_rank*prior_sociality_index,
    
    c(a_id, b_age_id, b_rank_id, b_sociality_index_id)[id] ~ dmvnormNC(sigma_id, Rho_id),
    
    c(a) ~ dnorm(0,2),
    c(b_age, b_rank, b_sociality_index, b_rankXage, b_rankXsociality_index) ~ dnorm(0,2),
    c(sigma_id) ~ dexp(1),
    c(Rho_id) ~ dlkjcorr(3),
    sigma ~ dexp(1)
    
  ),
  
  data=data.input, cores=3, chains=3, warmup=2000, iter=4000, control=list(adapt_delta=0.99), WAIC=TRUE
  
)
